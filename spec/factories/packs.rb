FactoryGirl.define do
  factory :pack do
    name 'test'
    current false
    user

    factory :pack_with_cards do
      transient do
        cards_count 5
      end

      after(:create) do |pack, evaluator|
        create_list(:card, evaluator.cards_count, pack: pack)
        pack.cards.update_all(review_date: 7.days.ago)
      end
    end
  end
end
