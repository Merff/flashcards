require 'rails_helper'

describe 'Check answer' do

  it "true answer" do
    card = create(:card, original: "star", translated: "звезда")
    visit root_path
    fill_in :answer, with: "star"
    click_button "Проверить"
    expect(page).to have_content "Верный ответ!"
  end
end