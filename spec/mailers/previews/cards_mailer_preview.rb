# Preview all emails at http://localhost:3000/rails/mailers/cards_mailer
class CardsMailerPreview < ActionMailer::Preview
  def notify_cards_need_review
    CardsMailer.pending_cards_notification(User.first)
  end
end
