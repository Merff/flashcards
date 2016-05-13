require 'rails_helper'

describe Card do 

  let!(:card) { create(:card, original: "space", translated: "космос") }

  it "when create, date review must be +3 days" do
    expect(card.set_review).to eq(Date.today.next_day(3))
  end

  it "answer right/false" do
    expect(card.check_translation("space")).to be true
    expect(card.check_translation("star")).to be false
  end

  it "random card in home page" do
    card.update_attributes(review: Date.today)
    expect(Card.random_card.nil?).to be false
  end
end