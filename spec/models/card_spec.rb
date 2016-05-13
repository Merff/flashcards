require 'rails_helper'

describe Card do 

  let(:user) { create(:user) }

  before(:each) do
    login("test", "user")
  end

  it "when create, date review must be +3 days" do
    user.cards.create(original: "space", translated: "космос")
    expect(card.set_review).to eq(Date.today.next_day(3))
  end

  it "answer right" do
    user.cards.create(original: "war", translated: "война")
    expect(card.check_translation("war")).to be true
    expect(card.check_translation("star")).to be false
  end

  it "random card in home page" do
    user.cards.create(original: "black", translated: "черный", review: Date.today)
    expect(user.cards.random_card.nil?).to be false
  end
end