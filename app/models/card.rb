class Card < ActiveRecord::Base
	validates :original, :translated, presence: true
	validate :valid_combo
	before_create :create_date_review
	
	def valid_combo
		if original.downcase == translated.downcase
			errors.add(:translated, "translated not equal original")
		end
	end

	def create_date_review
		review = Date.today.next_day(3)
	end

	scope :random_card, -> {where("review <= ?", Date.today).order('RANDOM()').limit(1).take}

	def check_translation(answer)
		if answer.downcase == original.downcase
			update_attributes(review: Date.today.next_day(3))
		else
			false
		end
	end

end
