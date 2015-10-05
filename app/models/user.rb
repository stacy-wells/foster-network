class User < ActiveRecord::Base
  has_many :fosters, class_name: "Animal", foreign_key: "fostered_by_id"
  has_many :animals, class_name: "Animal", foreign_key: "animal_rescue_id"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :rescue_group, inclusion: [true, false]
end
