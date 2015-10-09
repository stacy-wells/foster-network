require "rails_helper"

feature "user can delete an animal", %{
  As a user
  I want to delete an animal
  So it is no longer visiable

  Acceptance Criteria
  [x] - User must be signed in
  [x] - User must have a rescue account
  [x] - User can see the 'Delete' link next to that animal on their show page
  [x] - User can see the 'Delete' link on the animal's show page
  [x] - User should be prompted with an alert box before deleting the animal
  [x] - User should be notified of success if their animal has been delete
  [x] - User should see no longer see the animal's information on their show page

} do
  feature "User signs in" do
    before(:each) do
      @user = FactoryGirl.create(:user, rescue_group: true)
      @animal = FactoryGirl.create(:animal, animal_rescue_id: @user.id)

      visit new_user_session_path
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_button "Log in"
      click_link @user.email
    end

    scenario "User can see the delete link from their show page" do
      expect(page).to have_content "Delete"
    end

    scenario "User can see the delete link from the animal's show page" do
      click_link @animal.name
      expect(page).to have_content "Delete"
    end

    scenario "User clicks 'Delete' on their show page" do
      click_link "Delete"

      # expect(message).to have_content "Are you sure?"
      expect(page).to_not have_content "@animal.name"
    end

    scenario "User clicks 'Delete' on the animal's show page" do
      click_link @animal.name
      click_link "Delete"

      # expect(message).to have_content "Are you sure?"
      expect(page).to_not have_content "@animal.name"
    end

    feature "user is not signed in" do
      scenario "user does not see delete button on animal's show page" do
        click_link "Sign Out"

        expect(page).to_not have_content "Delete"
      end
    end
  end
end
