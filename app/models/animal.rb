class Animal < ActiveRecord::Base
  belongs_to :animal_rescue, class_name: 'User'
  belongs_to :fostered_by, class_name: 'User'
end
