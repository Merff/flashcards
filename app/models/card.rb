class Card < ActiveRecord::Base
	validates :original, :translated, presence: true, if: :valid_combo?
	before_create :create_date_review
	
	def valid_combo?
		:original != :translated
	end

	def create_date_review
		self.review = Date.today.next_day(3)
	end
end
#{ case_sensitive: false }