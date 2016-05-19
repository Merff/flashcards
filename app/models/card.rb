class Card < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  belongs_to :user
  belongs_to :deck

  validates :original, :translated, :user_id, :deck_id, presence: true
  validate :valid_combo
  before_create review: DateTime.now

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
      end
    end
  end

  def set_review
    hash = { 1 => 12.hours, 
             2 => 3.days, 
             3 => 7.days, 
             4 => 14.days, 
             5 => 30.days }
    if true_answers >= 6
      update_attributes(review: (DateTime.now + 30.days))
    else
      update_attributes(review: (DateTime.now + hash[true_answers]))
    end   
  end

end
