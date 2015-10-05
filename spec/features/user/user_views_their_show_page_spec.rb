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
  feature "User views their show page" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      visit new_user_session_path
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_button "Log in"
    end
  #
    #   scenario "User clicks on their email to see their show page" do
    #     click_link @user.email
    #
    #     expect(page).to have_content @user.first_name
    #     expect(page).to have_content @user.email
    #     expect(page).to have_content @user.animals[0]
    #   end
    #
    #   scenario "User clicks link to edit their information" do
    #   visit root_path
    #   click_link @user.email
    #   click_link("Edit your information")
    #
    #   expect(page).to have_content("Edit your information here:")
    # end
  end
end