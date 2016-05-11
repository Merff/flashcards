require 'rails_helper'

describe 'check answer' do
  before(:each) do
    card = Card.create(original: "star", translated: "звезда").update_attributes(review: Date.today)
  end

  it "true answer" do
    
    visit root_path
    fill_in :answer, with: "star"
    click_button "Проверить"
    expect(page).to have_content "Верный ответ!"
  end
end