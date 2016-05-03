class Card < ActiveRecord::Base
	validates :original, :translated,  presence: true

end
