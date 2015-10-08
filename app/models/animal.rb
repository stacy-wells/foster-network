class Animal < ActiveRecord::Base
  mount_uploader :animal_photo, AnimalPhotoUploader

  belongs_to :animal_rescue, class_name: "User"
  belongs_to :fostered_by, class_name: "User"

  validates :name, presence: true
  validates :species, presence: true
  validates :species, inclusion: ["Dog", "Cat"]
  validates :gender, inclusion: ["Female", "Male"]
  validates :age, inclusion: ["1-3 years", "3-6 years", "6-10 years",
                              "10-14 years", "under a year", "over 15 years"]
  validates :size, inclusion: ["Extra Small: under 10lbs",
                               "Small: 10lbs to 20lbs",
                               "Medium: 21lbs to 40lbs",
                               "Large: 41lbs to 74lbs",
                               "Extra Large: Over 75lbs"]
  validates :fixed, inclusion: [true, false]
  validates :dog_friendly, inclusion: [true, false]
  validates :cat_friendly, inclusion: [true, false]
  validates :kid_friendly, inclusion: [true, false]
  validates :animal_rescue, presence: true
end
