# ruby encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
words_list_url = 'http://1000mostcommonwords.com/1000-most-common-german-words/'
page = Nokogiri::HTML(open(words_list_url).read)
trs = page.xpath('//*[@id="post-188"]/div/table/tbody/tr[position() > 1]')
Card.destroy_all
user = User.create(email: 'test@gmail.com', password: 'gfhjkm', password_confirmation: 'gfhjkm')
cards = trs.map do |tr|
  german = tr.xpath('td[2]').text
  english = tr.xpath('td[3]').text
  Card.create(original_text: german, translated_text: english, review_date: 3.days.ago, user: user)
end
p "Created #{cards.count} cards"
