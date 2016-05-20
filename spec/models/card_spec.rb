require 'rails_helper'

describe Card do 
  let!(:user) { create(:user) }
  let!(:deck) { create(:deck, user: user) }
  let!(:card) { create(:card, user: user, deck: deck) }

  it "answer right/false" do
    expect(card.check_translation("star")).to be true
    expect(card.check_translation("space")).to be false
  end

  it "random card in home page" do
    expect(Card.random_card.nil?).to be false
  end

  it "set review when create card" do
    expect(card.review).to eq(DateTime.now.to_date)
  end

  it "when have 1 true answer, review after 12 hours" do
    card.check_translation("star")
    expect(card.review).to eq((DateTime.now + 12.hours).to_date)
  end

  it "when have 2 true answers, review after 3 days" do
    2.times do card.check_translation("star") end
    expect(card.review).to eq(DateTime.now.to_date + 3.days)
  end

  it "when have 3 true answers, review after 1 week" do
    3.times do card.check_translation("star") end
    expect(card.review).to eq(DateTime.now.to_date + 1.week)
  end

  it "when have 4 true answers, review after 2 weeks" do
    4.times do card.check_translation("star") end
    expect(card.review).to eq(DateTime.now.to_date + 2.week)
  end

  it "when have 5 true answers, review after 1 month" do
    5.times do card.check_translation("star") end
    expect(card.review).to eq(DateTime.now.to_date + 1.month)
  end

  it "when have 1 false answer, review not changes" do
    card.check_translation("space")
    expect(card.review).to eq(DateTime.now.to_date)
  end

  it "when have 2 false answer, review not changes" do
    2.times do card.check_translation("space") end
    expect(card.review).to eq(DateTime.now.to_date)
  end

  it "when have 3 false answer, review after 12 hours" do
    3.times do card.check_translation("space") end
    expect(card.review).to eq((DateTime.now + 12.hours).to_date)
  end 
end