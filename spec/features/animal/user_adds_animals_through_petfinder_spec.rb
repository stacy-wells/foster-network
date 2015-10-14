require "rails_helper"

feature "user can add an animals through the Petfinder API", %{
  As a user
  I want to add the animals I have on my Petfinder accout
  So I can add my animals quickly

  Acceptance Criteria
  [x] - User must be signed in
  [x] - User must have a rescue account
  [x] - User can navigate to the add an animal form from their show page
  [x] - User should input their Petfinder ID
  [x] - User should navigate to the show page after the animals have been created
  [x] - User should be notified of success if their animals have been added
  [x] - User should be notified of failure if they don't fill out the form (JS)
  [x] - User should see the new animals on their show page

} do
  feature "User is signed in as a rescue" do
    before(:each) do
      @user = FactoryGirl.create(:user, rescue_group: true)
      visit new_user_session_path
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_button "Log in"
      visit user_path(@user)
    end

    scenario "User navigates to the Petfinder page from their show page" do
      click_link "Add an animal"
      click_link "Petfinder"

      expect(page).to have_content "Connect with PetFinder"
    end

    scenario "User inputs their Petfinder ID and click 'Submit'" do
      click_link "Add an animal"
      click_link "Petfinder"

      fill_in "Shelter ID", with: "MA219"
      click_button "Petfinder"

      expect(page).to have_content("Ginger")
      expect(page).to have_content("Cinnamon")
      expect(page).to have_content("Oscar")
      expect(page).to have_content("Disney")
    end

    scenario "User adds their animals from Petfinder and recieves a
    notification of success" do
      click_link "Add an animal"
      click_link "Petfinder"

      fill_in "Shelter ID", with: "MA219"
      click_button "Petfinder"

      expect(page).to have_content("Your animals have been added.")
    end
  end
end
