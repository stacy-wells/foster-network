require "rails_helper"

feature "user notifies the users in thier search results", %{
  As a user
  I want to email the users in my search results
  So that I can find more foster homes

  Acceptance Criteria
  [x] - User must be an animal rescue
  [x] - User must preform a search
  [x] - User must click 'Notify' button
  [x] - User should see a notification of success
} do
  feature "user is signed in as a rescue" do
    before(:each) do
      @rescue_group = FactoryGirl.create(:user, rescue_group: true)
      @foster = FactoryGirl.create(:user, rescue_group: false)
      @animal = FactoryGirl.create(:animal, animal_rescue_id: @rescue_group.id)
      visit new_user_session_path
      fill_in "Email", with: @rescue_group.email
      fill_in "Password", with: @rescue_group.password
      click_button "Log in"
    end

    scenario "user performs a search, sees results and 'Notify' button" do
      click_link @rescue_group.email
      click_link "Find foster homes"

      click_button "Search"

      expect(page).to have_content "Notify"
    end

    scenario "user performs a search, and notify's results" do
      click_link @rescue_group.email
      click_link "Find foster homes"

      click_button "Search"
      click_link "Notify"

      expect(page).to have_content("1 user(s) have been emailed!")
    end
  end

  feature "user does not have a rescue account" do
    scenario "user does not see 'Find foster homes' link" do
      @foster = FactoryGirl.create(:user, rescue_group: false)
      visit new_user_session_path
      fill_in "Email", with: @foster.email
      fill_in "Password", with: @foster.password
      click_button "Log in"
      click_link @foster.email

      expect(page).to_not have_content("Find foster homes")
    end
  end
end
