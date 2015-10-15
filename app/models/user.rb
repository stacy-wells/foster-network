class User < ActiveRecord::Base
  include DeviseHelper

  mount_uploader :profile_photo, ProfilePhotoUploader

  has_many :fosters, class_name: "Animal", foreign_key: "fostered_by_id"
  has_many :animals, class_name: "Animal", foreign_key: "animal_rescue_id"
  has_many :foster_offers
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :rescue_group, inclusion: [true, false]
  validates :description, length: { maximum: 300 }
end
