class Card < ActiveRecord::Base
  PERIODICITY = [-1.hour, 12.hour, 3.day, 1.week, 2.week, 1.month]
  mount_uploader :avatar, AvatarUploader
  belongs_to :user
  belongs_to :deck

  validates :original, :translated, :user_id, :deck_id, presence: true
  validate :valid_combo
  before_create :set_default_review

  def set_default_review
    self.review = DateTime.now
  end

  def valid_combo
    if original.downcase == translated.downcase
      errors.add(:translated, "translated not equal original")
    end
  end

  scope :overdue, -> { where("review <= ?", DateTime.now) }

  def self.random_card
    overdue.order('RANDOM()').take
  end

  def check_translation(answer)
    if answer.downcase == original.downcase
      update_attributes(true_answers: true_answers+1, try: 0)
      set_review
    else
      if (answer.downcase != original.downcase) && (try < 2)
        update_attributes(try: try+1)
        false
      else
        update_attributes(review: DateTime.now + 12.hours, try: 0)
        false
      end
    end
  end

  def check_levenshtein(answer)
    DamerauLevenshtein.distance(answer, original) == 1
  end
  
  def set_review
    time = if true_answers >= 6
      1.month
    else
      PERIODICITY[true_answers]
    end
    update_attributes(review: DateTime.now + time)
  end

  def notify_train_card
    overdue.each do |card|
      NotificationsMailer.card_notice(card).deliver_now
    end
  end
end
