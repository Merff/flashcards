class Card < ActiveRecord::Base
  validates :original, :translated, presence: true
  validate :valid_combo
  before_create :set_review

  def valid_combo
    if original.downcase == translated.downcase
      errors.add(:translated, "translated not equal original")
    end
  end

  def set_review
    review = Date.today.next_day(3)
  end

  scope :overdue, -> { where("review <= ?", Date.today) }

  def self.random_card
    overdue.order('RANDOM()').take
  end

  def check_translation(answer)
    if answer.downcase == original.downcase
      update_attributes(review: Date.today.next_day(3))
    else
      false
    end
  end
end
