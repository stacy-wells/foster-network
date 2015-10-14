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
    has_dogs false
    has_cats false
    has_kids false
  end

  factory :animal do
    name "Roscoe"
    animal "Dog"
    sex "M"
    age "Young"
    description "Loves to run!"
    dog_friendly true
    cat_friendly true
    animal_photo { Rack::Test::UploadedFile.new(File.join(
      Rails.root, "spec", "support", "images", "default-profile.jpeg")) }
    animal_rescue_id 1
    shelter_id "MA219"
    status "A"
  end
end
