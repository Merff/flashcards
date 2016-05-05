class Card < ActiveRecord::Base
	validates :original, :translated, presence: true
	validate :valid_combo 
	before_create :create_date_review
	
	def valid_combo
		if self.original.upcase == self.translated.upcase
			errors.add(:translated, "translated not equal original")
		end
	end

	def create_date_review
		self.review = Date.today.next_day(3)
	end
end
