class Search < ActiveRecord::Base
  validates :dog_friendly, inclusion: [true, false, nil]
  validates :cat_friendly, inclusion: [true, false, nil]
  validates :kid_friendly, inclusion: [true, false, nil]

  def search_users
    users = User.all

    users = users.where(rescue_group: false)
    users = users.where(["has_dogs = ?", dog_friendly]) if dog_friendly == false
    users = users.where(["has_cats = ?", cat_friendly]) if cat_friendly == false
    users = users.where(["has_kids = ?", kid_friendly]) if kid_friendly == false
    users = users.where(["city LIKE ?", city]) if city.present?
    users = users.where(["state LIKE ?", state]) if state.present?
    users = users.where(["name ILIKE ?", name]) if name.present?
    users = users.where(["email LIKE ?", email]) if email.present?

    if !dog_friendly?
      array = []
      users.each do |user|
        if user.fosters.empty?
          array << user
        end
      end
      users = array
    end

    return users
  end
end
