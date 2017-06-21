class CardsMailer < ApplicationMailer
  default from: 'notifications@flashcards.ru'

  def pending_cards_notification(user)
    @user = user
    @url = ENV['APP_URL']
    mail(to: @user.email, subject: 'Flashcards: пора повторить карточки!')
  end
end
