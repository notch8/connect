FactoryGirl.define do
  factory :message do
    sequence(:body) { |n| "Test Body #{n}" }
    sent_at Time.now
    association :user
    association :need
  end
end