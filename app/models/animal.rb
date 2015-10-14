class Animal < ActiveRecord::Base
  mount_uploader :animal_photo, AnimalPhotoUploader

  belongs_to :animal_rescue, class_name: "User"
  belongs_to :fostered_by, class_name: "User"
  has_many :foster_offers

  validates :name, presence: true
  validates :animal_rescue, presence: true
  validates :animal, presence: true
  validates :sex, presence: true
  validates :age, inclusion: ["Baby", "Young", "Adult", "Senior"]

  def self.age_options
    ["Baby", "Young", "Adult", "Senior"]
  end
end
