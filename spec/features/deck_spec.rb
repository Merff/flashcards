require 'rails_helper'

describe Deck do
  let!(:user) { create(:user) }
  let!(:deck) { create(:deck, user: user) }
  let!(:card) { create(:card, user: user, deck: deck) }
  
  before(:each) do
    login("test", "user")
    card.update_attributes(review: DateTime.now)
  end

  it "user have deck" do
    visit root_path
    click_link 'Список колод'
    expect(page).to have_content "kosmos"
  end

  it "user can create new deck" do
    click_link 'Создать колоду'
    fill_in :deck_name, with: "Interstellar"
    click_button 'Создать колоду'
    expect(page).to have_content "Interstellar"
  end

  it "train deck's card after deck has been current " do
    click_link 'Список колод'
    click_link 'Сделать текущей'
    expect(page).to have_content "звезда"
  end
end