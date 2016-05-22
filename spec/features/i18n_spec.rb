require 'rails_helper'

describe "I18n"  do

  context "for login user" do
    let!(:user) { create(:user) }

    before(:each) do
      login("test", "user")
      visit root_path
      click_link I18n.t('edit_profile')
    end

    it "en locale" do
      choose 'en'
      click_button I18n.t('update_profile')
      expect(page).to have_content "Flashcards"
    end

    it "ru locale" do
      choose 'ru'
      click_button I18n.t('update_profile')
      expect(page).to have_content "Флешкарточкер"
    end
  end

  context "for not login user" do
    before(:each) do
      visit root_path
    end

    it "can choose en locale in header" do
      click_link "en"
      expect(page).to have_content "Flashcards"
    end

    it "can choose ru locale in header" do
      click_link "ru"
      expect(page).to have_content "Флешкарточкер"
    end
  end
end

