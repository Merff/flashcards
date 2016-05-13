require 'rails_helper'

describe 'Cards answer' do

  let!(:user) { create(:user) }

  before(:each) do
    login("test", "user")
    @card = user.cards.create(:card, original: "star", translated: "звезда")
  end

  context "check answer" do
    before(:each) do
      @card.update_attributes(review: Date.today)
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
  end
end