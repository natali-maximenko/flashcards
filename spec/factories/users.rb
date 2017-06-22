FactoryGirl.define do
  factory :user do
    email 'test@gmail.com'
    locale 'ru'
    password 'paSsWodD'
    password_confirmation { password }

    factory :user_with_packs do
      transient do
        packs_count 3
      end

      after(:create) do |user, evaluator|
        create_list(:pack_with_cards, evaluator.packs_count, user: user)
      end
    end
  end

  factory :empty_user, class: User do
    email 'test'
    password '12'
    password_confirmation '21'
  end
end
