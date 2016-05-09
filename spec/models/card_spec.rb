require 'rails_helper'

describe Card do 
	
	it "when create, date review must be +3 days" do
		card = Card.create(original: "space", translated: "космос")
		expect(card.create_date_review).to eq(Date.today.next_day(3))
	end

	it "answer right" do
		card = Card.create(original: "war", translated: "война")
		expect(card.check_translation("war")).to be true
		expect(card.check_translation("star")).to be false
	end

	it "random card in home page" do
		test_card = Card.create(original: "black", translated: "черный", review: "2016-05-09")
		card = Card.random_card
		expect(card.nil?).to be false
	end
end