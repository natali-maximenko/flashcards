FactoryGirl.define do
  factory :empty_card, class: Card do
    original_text ''
    translated_text ''
    review_date nil
  end

  factory :card do
    original_text 'mit'
    translated_text 'with'
    review_date { Date.today }
  end
end