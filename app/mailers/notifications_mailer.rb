class NotificationsMailer < ApplicationMailer

  def card_notice(card)
    user = card.user
    mail(to: user.email, subject: 'У вас есть карточки, которые хотят учиться)')
  end
end
