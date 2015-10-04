require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password "password"
    password_confirmation "password"
    first_name "Elizabeth"
    last_name "Lemon"
    city "New York"
    state "NY"
  end

end
