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
    rescue_group false
  end

  factory :animal do
    name "Max"
    rescue_group user
  end
end
