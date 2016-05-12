require 'rails_helper'

describe 'Card' do
  before(:each) do
    @card = create(:card, original: "star", translated: "звезда")
  end

  context "Check answer" do
    before(:each) do
      @card.update_attributes(review: Date.today)
    end

    it "true answer" do
      visit root_path
      fill_in :answer, with: "star"
      click_button "Проверить"
      expect(page).to have_content "Верный ответ!"
    end

    it "false answer" do
      visit root_path
      fill_in :answer, with: "star wars"
      click_button "Проверить"
      expect(page).to have_content "Неверный ответ("
    end
  end
end