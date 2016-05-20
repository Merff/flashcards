require 'rails_helper'

describe Card do
  let!(:user) { create(:user) }
  let!(:deck) { create(:deck, user: user) }
  let!(:card) { create(:card, user: user, deck: deck) }
  
  before(:each) do
    login("test", "user")
  end

  it "page after login" do
    expect(page).to have_content "Успешный вход!"
  end 

  context "check answer" do
    before(:each) do
      card.update_attributes(review: DateTime.now)
    end

    it "open train page and post true answer" do
      visit root_path
      fill_in :answer, with: "star"
      click_button "Проверить"
      expect(page).to have_content "Верный ответ!"
    end

    it "open train page and post false answer" do
      visit root_path
      fill_in :answer, with: "star wars"
      click_button "Проверить"
      expect(page).to have_content "Неверный ответ("
    end

    it "open train page and post answer with typo" do
      visit root_path
      fill_in :answer, with: "stra"
      click_button "Проверить"
      expect(page).to have_content "возможно вы опечатались"
    end
  end
end