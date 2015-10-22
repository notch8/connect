FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Test Name #{n}" }
    sequence(:email) { |n| "test_#{n}@example.com" }
    password "testing123"
  end

  factory :admin_user, class: User do
    sequence(:name) { |n| "Test Name #{n}" }
    sequence(:email) { |n| "admin_test_#{n}@example.com" }
    password "testing123"
    is_admin true
  end
end