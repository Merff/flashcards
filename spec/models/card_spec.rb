require 'rails_helper'

describe Card do 
	
	it "translated text not equal original" do
		card = Card.create(original: "space", translated: "Space")
		expect(card.original.upcase).to eq(card.translated.upcase)
	end

	it "date review must be +3 days" do
		card = Card.create(original: "space", translated: "космос")
		expect(card.review).to eq(Date.today.next_day(3))
	end

	it "answer must be correct" do
		card = Card.new(original: "war")
		answer = "WaR"
		expect(answer.upcase).to eq(card.original.upcase)
	end
end