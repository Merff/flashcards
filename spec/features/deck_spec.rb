require 'rails_helper'

describe Deck do

  let!(:deck) { create(:deck) }
  
  before(:each) do
    login("test", "user")
  end

  it "user have deck" do
    visit root_path
    click_link "Все колоды"
    expect(page).to have_content "kosmos"
  end

  it "user can create new deck" do
    click_link "Добавить колоду"
    fill_in :deck_name, with: "Interstellar"
    click_button "Create Deck"
    expect(page).to have_content "Имя колоды Interstellar"
  end

  it "deck can been current" do
    click_link "Все колоды"
    expect(page).to have_button "Сделать текущей"
  end
end