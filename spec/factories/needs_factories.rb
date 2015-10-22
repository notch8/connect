FactoryGirl.define do
  factory :need do
    sequence(:title) { |n| "Test Title #{n}" }
    amount_requested 10000
  end
end