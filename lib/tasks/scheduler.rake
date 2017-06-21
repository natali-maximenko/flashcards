desc 'This task is called by the Heroku scheduler add-on'
task notify_cards_need_review: :environment do
  User.notify_cards_need_review
end
