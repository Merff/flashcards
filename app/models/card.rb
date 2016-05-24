class Card < ActiveRecord::Base
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
    update_params = SuperMemo.execute(review, original, answer, efactor, repeat, interval, quality)
    update(update_params)
  end
  
  def notify_train_card
    overdue.each do |card|
      NotificationsMailer.card_notice(card).deliver_now
    end
  end
end
