class FosterOffer < ActiveRecord::Base
  belongs_to :user
  belongs_to :animal

  validates :user_id, presence: true
  validates :animal_id, presence: true
  validates :animal_rescue_id, presence: true
  validates :animal_rescue_id, numericality: { only_integer: true }
end
