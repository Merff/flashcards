require 'rails_helper'

describe 'check answer' do
  before(:each) do
    @card = create(:card, original: "star", translated: "звезда")
  end

  it "true answer" do
    @card.update_attributes(review: Date.today)
    visit root_path
    fill_in :answer, with: "star"
    click_button "Проверить"
    expect(page).to have_content "Верный ответ!"
  end
end