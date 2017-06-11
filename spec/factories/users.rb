FactoryGirl.define do
  factory :user do
    email 'test@gmail.com'
    password 'paSsWodD'
    password_confirmation { password }

    factory :user_with_cards do
      transient do
        cards_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:card, evaluator.cards_count, user: user)
        user.cards.update_all(review_date: 7.days.ago)
      end
    end
  end

  factory :empty_user, class: User do
    email 'test'
    password '12'
    password_confirmation '21'
  end
end
