require "rails_helper"

feature "user can view their show page", %{
  As a user
  I want to be able to sign up
  So that I can build a profile page

  Acceptance Criteria
  [] - User must be signed in
  [] - User can navigate to their show page from the index page
  [] - User can view their name, email, and the animals they are fostering
  [] - User can click a link edit their profile that takes them to a new page

} do
  feature "User signs in" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      visit new_user_session_path
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_button "Log in"
    end

    scenario "User clicks on their email to see their show page" do
      @rescue_group = FactoryGirl.create(:user, rescue_group: true)
      FactoryGirl.create(:animal, animal_rescue_id: @rescue_group.id, fostered_by_id: @user.id)
      click_link @user.email

      expect(page).to have_content @user.name
      expect(page).to have_content @user.email
      expect(page).to have_content @user.fosters[0].name
    end

    scenario "User clicks link to edit their information" do
      visit root_path
      click_link @user.email
      click_link("Update your information here.")

      expect(page).to have_content("Edit your information here:")
    end
  end
end
