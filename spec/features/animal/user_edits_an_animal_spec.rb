require "rails_helper"

feature "user can edit an animal", %{
  As a user
  I want to edit an animal
  So other users can see the correct details about that animal

  Acceptance Criteria
  [x] - User must be signed in
  [x] - User can navigate to the update an animal form from their show page
  [x] - User should see a link next to the animal to access the update page
  [x] - User should see the form displayed correctly
  [x] - User should be notified of success if their animal has been saved
  [x] - User should see their updated information on their show page

} do
  feature "User adds an animal" do
    before(:each) do
      @user = FactoryGirl.create(:user, rescue_group: true)
      @animal = FactoryGirl.create(:animal, animal_rescue_id: @user.id)
      visit new_user_session_path
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_button "Log in"
    end

    scenario "User navigates to the update an animal page from their show page" do
      click_link "Update"

      expect(page).to have_content "Update Roscoe"
    end

    scenario "User sees the update an animal form diplayed correctly" do
      click_link "Update"

      expect(page).to have_content "Update Roscoe"
      expect(page).to have_content "Name"
      expect(page).to have_content "Species"
      expect(page).to have_content "Gender"
      expect(page).to have_content "Size"
      expect(page).to have_content "Age"
      expect(page).to have_content "Description"
    end

    feature "User fills out form correctly" do
      scenario "User sees notification of success" do
        click_link "Update"

        fill_in "Name", with: "Petie"
        select "Large: 41lbs to 74lbs", from: "Size"
        click_button "Update"

        expect(page).to have_content "Petie has been updated!"
        expect(page).to have_content "Large: 41lbs to 74lbs"
      end
    end
  end
end
