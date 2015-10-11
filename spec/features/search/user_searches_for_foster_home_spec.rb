require "rails_helper"

feature "user searches for foster homes", %{
  As a user
  I want to search for foster homes
  So that I can ask certain users if they would like to foster

  Acceptance Criteria
  [x] - User must be an animal rescue
  [x] - User must be able to navigate from their show page to the search page
  [x] - User should see the search form displayed correctly
  [x] - User should be taken to the search show page after clicking search
  [x] - User see a list of results on the search show page
  [x] - User should be able to navigate to a user's show page by clicking on
        their email
  [x] - User should be notified if there are no matches
} do
  feature "Users are created" do
    before(:each) do
      @rescue_group = FactoryGirl.create(:user, rescue_group: true)
      @foster = FactoryGirl.create(:user, rescue_group: false)
      @animal = FactoryGirl.create(:animal, animal_rescue_id: @rescue_group.id)
      FosterOffer.create!(animal_id: @animal.id, user_id: @foster.id,
                          animal_rescue_id: @rescue_group.id)
    end

    feature "user is not a rescue group" do
      scenario "user is on their show page and does not see the link to the
        search page" do
        visit new_user_session_path
        fill_in "Email", with: @foster.email
        fill_in "Password", with: @foster.password
        click_button "Log in"

        click_link @foster.email

        expect(page).to_not have_content("Find foster homes")
      end
    end

    feature "user is a rescue group" do
      scenario "user sees search link on their show page" do
        visit new_user_session_path
        fill_in "Email", with: @rescue_group.email
        fill_in "Password", with: @rescue_group.password
        click_button "Log in"

        click_link @rescue_group.email

        expect(page).to have_content("Find foster homes")
      end

      scenario "user clicks on search link and is taken to the search show page" do
        visit new_user_session_path
        fill_in "Email", with: @rescue_group.email
        fill_in "Password", with: @rescue_group.password
        click_button "Log in"

        click_link @rescue_group.email
        click_link "Find foster homes"

        expect(page).to have_content("Find Foster Homes")
        expect(page).to have_content("Foster's name")
        expect(page).to have_content("Foster's email")
        expect(page).to have_content("Can they have dogs in the home?")
        expect(page).to have_content("Can they have cats in the home?")
        expect(page).to have_content("Can they have kids in the home?")
        expect(page).to have_content("City")
        expect(page).to have_content("State")
      end

      scenario "user searches for foster homes that do not have any dogs" do
        visit new_user_session_path
        fill_in "Email", with: @rescue_group.email
        fill_in "Password", with: @rescue_group.password
        click_button "Log in"

        click_link @rescue_group.email
        click_link "Find foster homes"

        select "No", from: "Can they have dogs in the home?"
        click_button "Search"

        expect(page).to have_content @foster.email
        expect(page).to have_content @foster.name
      end

      scenario "user searches for foster homes that do not have any cats, kids,
        or dogs" do
        visit new_user_session_path
        fill_in "Email", with: @rescue_group.email
        fill_in "Password", with: @rescue_group.password
        click_button "Log in"

        click_link @rescue_group.email
        click_link "Find foster homes"

        select "No", from: "Can they have dogs in the home?"
        select "No", from: "Can they have cats in the home?"
        select "No", from: "Can they have kids in the home?"
        click_button "Search"

        expect(page).to have_content @foster.email
        expect(page).to have_content @foster.name
      end

      scenario "user searches for foster homes by the user's name" do
        visit new_user_session_path
        fill_in "Email", with: @rescue_group.email
        fill_in "Password", with: @rescue_group.password
        click_button "Log in"

        click_link @rescue_group.email
        click_link "Find foster homes"

        fill_in "Foster's name", with: @foster.name
        click_button "Search"

        expect(page).to have_content @foster.email
        expect(page).to have_content @foster.name
      end

      scenario "user searches for foster homes by email" do
        visit new_user_session_path
        fill_in "Email", with: @rescue_group.email
        fill_in "Password", with: @rescue_group.password
        click_button "Log in"

        click_link @rescue_group.email
        click_link "Find foster homes"

        fill_in "Foster's email", with: @foster.email
        click_button "Search"

        expect(page).to have_content @foster.email
        expect(page).to have_content @foster.name
      end

      scenario "user registers with no dogs in the home, accepts a foster, and
        does not show up in the search results for a dog free home" do
        @animal = FactoryGirl.create(:animal,
                                     animal_rescue_id: @rescue_group.id,
                                     fostered_by_id: @foster.id)

        visit new_user_session_path
        fill_in "Email", with: @rescue_group.email
        fill_in "Password", with: @rescue_group.password
        click_button "Log in"

        click_link @rescue_group.email
        click_link "Find foster homes"

        select "No", from: "Can they have dogs in the home?"
        click_button "Search"

        expect(page).to_not have_content @foster.name
        expect(page).to_not have_content @foster.name
      end
    end
  end
end
