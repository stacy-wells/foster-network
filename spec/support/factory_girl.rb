require "factory_girl"

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password "password"
    password_confirmation "password"
    name "Elizabeth Lemon"
    city "New York"
    state "NY"
    rescue_group false
  end

  factory :animal do
    name "Roscoe"
    species "Dog"
    gender "Male"
    age "3-6 years"
    size "Large: 41lbs to 74lbs"
    description "Loves to run!"
    fixed true
    dog_friendly true
    cat_friendly true
    kid_friendly true
    animal_photo { Rack::Test::UploadedFile.new(File.join(
      Rails.root, "spec", "support", "images", "default-profile.jpeg")) }
    animal_rescue_id 1
  end
end
