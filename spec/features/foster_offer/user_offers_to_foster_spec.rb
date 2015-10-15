require "rails_helper"

feature "user volunteers to foster an animal", %{
  As a user
  I want volunteer to foster an animal
  So that the rescue knows I am interested in fostering

  Acceptance Criteria
  [x] - User must not be an animal rescue
  [x] - User should see 'Foster Me' next to the animal on the index page if that
       animal is not currently being fostered
  [x] - User should see notification of success
  [x] - Rescue must recieve an email when a new offer has been made
} do
  feature "Users are created" do
    before(:each) do
      @rescue_group = FactoryGirl.create(:user, rescue_group: true)
      @foster = FactoryGirl.create(:user, rescue_group: false)
      @animal = FactoryGirl.create(:animal, animal_rescue_id: @rescue_group.id)
    end

    scenario "User is a rescue and does not see 'Foster Me' button" do
      visit new_user_session_path
      fill_in "Email", with: @rescue_group.email
      fill_in "Password", with: @rescue_group.password
      click_button "Log in"

      expect(page).to_not have_content "Foster Me"
    end

    scenario "User is not a rescue and clicks button to foster" do
      visit new_user_session_path
      fill_in "Email", with: @foster.email
      fill_in "Password", with: @foster.password
      click_button "Log in"

      click_button "Foster Me!"
      expect(page).to have_content "#{@rescue_group.name} has been notified"
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end
