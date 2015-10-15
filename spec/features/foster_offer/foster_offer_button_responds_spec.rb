require "rails_helper"

feature "user offers to foster and sees button dissappear", %{
  As a user
  I want to no longer see the 'Foster Me' button after I click it
  So that I know what animals I have volunteered to foster

  Acceptance Criteria
  [x] - User must not have an animal rescue account
  [x] - User must click the 'Foster Me' button
  [x] - User should see the 'Foster Me' button after clicking it
  [x] - User should see that they have volunteered to foster that animal in the
        animal's div
} do
  feature "User signs in as a foster" do
    before(:each) do
      @rescue_group = FactoryGirl.create(:user, rescue_group: true)
      @foster = FactoryGirl.create(:user, rescue_group: false)
      @animal = FactoryGirl.create(:animal, animal_rescue_id: @rescue_group.id)
      visit new_user_session_path
      fill_in "Email", with: @foster.email
      fill_in "Password", with: @foster.password
      click_button "Log in"
    end

    scenario "user clicks 'Foster Me' and sees button disappear" do
      click_button "Foster Me"

      expect(page).to_not have_content("Foster Me")
      expect(page).to have_content("Foster offer sent!")
    end
  end

  feature "User signs in as an animal rescue" do
    before(:each) do
      @rescue_group = FactoryGirl.create(:user, rescue_group: true)
      @foster = FactoryGirl.create(:user, rescue_group: false)
      @animal = FactoryGirl.create(:animal, animal_rescue_id: @rescue_group.id)
      visit new_user_session_path
      fill_in "Email", with: @foster.email
      fill_in "Password", with: @foster.password
      click_button "Log in"
    end

    scenario "user views index page and does not see 'Foster Me' button" do
      expect(page).to_not have_content("Foster Me")
    end
  end
end
