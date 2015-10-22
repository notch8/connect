FactoryGirl.define do
  factory :donation do
    amount 10
    association :user
    association :need
  end
end