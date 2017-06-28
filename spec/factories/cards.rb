FactoryGirl.define do
  factory :empty_card, class: Card do
    original_text ''
    translated_text ''
    review_date nil
  end

  factory :card do
    original_text 'mit'
    translated_text 'with'
    review_date { 2.days.ago }
    pack
    review_count 0
    fail_count 2
    interval 0
    efactor 2.5
  end

  factory :haben_card, class: Card do
    original_text 'haben'
    translated_text 'have'
    review_date { Date.today }
    pack
  end
end
