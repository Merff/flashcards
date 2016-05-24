require 'rails_helper'

describe Card do 
  let!(:user) { create(:user) }
  let!(:deck) { create(:deck, user: user) }
  let!(:card) { create(:card, user: user, deck: deck) }

  it "random card in home page" do
    expect(Card.random_card.nil?).to be false
  end

  it "set review when create card" do
    expect(card.review).to eq(DateTime.now.to_date)
  end

  it "when have 1 succesful repeat, review tomorrow" do
    card.check_translation("star")
    expect(card.review).to eq(DateTime.now.to_date + 1.day)
  end

  it "when have 2 succesful repeats, review after 6 days" do
    2.times do card.check_translation("star") end
    expect(card.review).to eq(DateTime.now.to_date + 6.days)
  end

  it "when have 3 succesful repeats, review after 14 days" do
    3.times do card.check_translation("star") end
    expect(card.review).to eq(DateTime.now.to_date + 14.days)
  end

  it "when have 4 succesful repeats, review after 34 days" do
    4.times do card.check_translation("star") end
    expect(card.review).to eq(DateTime.now.to_date + 34.days)
  end

  it "when have false repeat, review tomorrow" do
    card.check_translation("space")
    expect(card.review).to eq(DateTime.now.to_date + 1.day)
  end

  it "when have 2 false repeats, review tomorrow" do
    2.times do card.check_translation("space") end
    expect(card.review).to eq(DateTime.now.to_date + 1.days)
  end

  it "when have typo in 3 repeat, review after 14 days" do
    2.times do card.check_translation("star") end
    card.check_translation("stra")
    expect(card.review).to eq(DateTime.now.to_date + 14.days)
  end

  it "when have typo in 4 repeat, review after 34 days" do
    3.times do card.check_translation("star") end
    card.check_translation("stra")
    expect(card.review).to eq(DateTime.now.to_date + 34.days)
  end  
end