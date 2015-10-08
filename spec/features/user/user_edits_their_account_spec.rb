require "rails_helper"

feature "user can edit their account information", %{
  As a user
  I want to edit my account information
  So that I have updated information displayed about me

  Acceptance Criteria
  [x] - User must be signed in
  [x] - User can navigate to their edit page from their show page
  [x] - User can edit their email, password, name, description,
       city, state, and photo
  [x] - User should navigate to their show page on submit
  [x] - User must provide current password to confirm changes
  [x] - User should be notified of success when their updates have been saved
  [x] - User should be notified of failure if their updates haven't been saved
  [x] - User should see their updated information on their show page

} do
  feature "User edits thier information" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      visit new_user_session_path
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_button "Log in"

      click_link @user.email
    end

    scenario "User navigates to their edit page from their show page and sees form" do
      click_link "Update your information here."

      expect(page).to have_content "Email"
      expect(page).to have_content "Name"
      expect(page).to have_content "Password"
      expect(page).to have_content "Password Confirmation"
      expect(page).to have_content "Description"
      expect(page).to have_content "City"
      expect(page).to have_content "State"
    end

    feature "User fills out form correctly" do
      scenario "User sees notification of success" do
        click_link "Update your information here."

        fill_in "Name", with: "Mary"
        fill_in "Current Password", with: @user.password
        attach_file "Profile Photo",
                    "#{Rails.root}/spec/support/images/profile.jpg"
        click_button "Update"

        user = User.last
        expect(page).to have_xpath(
          "//img[@src=\"/uploads/user/profile_photo/#{user.id}/profile.jpg\"]")
        expect(user.profile_photo.file.filename).to eq("profile.jpg")
        expect(page).to have_content "Mary"
        expect(page).to_not have_content "Elizabeth"
        expect(page).to have_content "Your changes have been saved."
      end

      scenario "User sees notification of success" do
        click_link "Update your information here."

        fill_in "City", with: "Boston"
        fill_in "Current Password", with: @user.password
        click_button "Update"

        expect(page).to have_content "Boston"
        expect(page).to_not have_content "New York"
        expect(page).to have_content "Your changes have been saved."
      end
    end

    feature "user fills out the form incorrectly" do
      scenario "user does not enter in a matching new password and password
      confirmation and sees error message" do
        click_link "Update your information here."

        fill_in "Password (leave blank", with: "12345678"
        fill_in "Password Confirmation", with: "01234567"
        fill_in "Current Password", with: @user.password
        click_button "Update"

        expect(page).to have_content("Password confirmation doesn't match Password")
      end

      scenario "user does not enter their current password to confirm their
      changes" do
        click_link "Update your information here."

        fill_in "City", with: "Boston"
        fill_in "Current Password", with: ""
        click_button "Update"

        expect(page).to have_content("Current password can't be blank")
      end
    end
  end
end
