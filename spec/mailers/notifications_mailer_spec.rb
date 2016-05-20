require "rails_helper"

RSpec.describe NotificationsMailer, type: :mailer do
  let!(:user) { create(:user) }
  let!(:card) { create(:card, user_id: user.id, deck_id: deck.id) }
  let!(:deck) { create(:deck, user_id: user.id) }
  let!(:mail) { described_class.card_notice(card).deliver_now }

  it 'renders the subject' do
    expect(mail.subject).to eq('У вас есть карточки, которые хотят учиться)')
  end

  it 'renders the receiver email' do
    expect(mail.to).to eq([user.email])
  end

  it 'renders the sender email' do
    expect(mail.from).to eq(['merff.555@gmail.com'])
  end
end
