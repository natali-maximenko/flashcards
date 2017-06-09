FactoryGirl.define do
  factory :user do
    email 'test@gmail.com'
    password 'paSsWodD'

    factory :user_with_cards do
      transient do
        cards_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:card, evaluator.cards_count, user: user)
      end
    end
  end

  factory :empty_user, class: User do
    email ''
    password ''
  end
end
