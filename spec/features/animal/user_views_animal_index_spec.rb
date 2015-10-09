require "rails_helper"

feature "user views all animals on index page", %{
  As a user
  I want to view the animal index page
  So I can see all of the animals

  Acceptance Criteria
  [x] - User should navigate to this page after sign in
  [x] - User can navigate to this page by clicking the 'Foster Network' link in
        the nav bar
  [x] - User should see all the animals displayed with their photo, name,
        species, gender, age, size
  [x] - User should see the appropriate icons for each animal depending on
        their diposition
  [x] - User should be able to click on an animal's name or 'See More' link and
        be taken to their show page

} do
  feature "User is signed in" do
    before(:each) do
      @user = FactoryGirl.create(:user, rescue_group: true)
      @animal = FactoryGirl.create(:animal, animal_rescue_id: @user.id)
      visit new_user_session_path
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_button "Log in"
    end

    scenario "User navigates to this page after signing in" do
      expect(page).to have_content "Animals in the Foster Network"
    end

    scenario "User can navigate to this page by clicking the 'Foster Network'
      link in the nav bar" do
      click_link @user.email
      click_link "Foster Network"

      expect(page).to have_content "Animals in the Foster Network"
    end

    scenario "should see all the animals displayed with their photo, name,
      species, gender, age, size" do
      expect(page).to have_content @animal.name
      expect(page).to have_content @animal.species
      expect(page).to have_content @animal.gender
      expect(page).to have_content @animal.age
      expect(page).to have_content @animal.size
      expect(page).to have_xpath(
        "//img[@src=\"/uploads/animal/animal_photo/#{@animal.id}/default-profile.jpeg\"]")
    end

    scenario "User should see the appropriate icons for each animal depending on
      their diposition" do
      expect(page).to have_css(".icons")
    end

    feature "User should be able to click on an animal's name or 'See More' link
      and be taken to their show page" do
      scenario "User clicks on animal's name" do
        click_link "Roscoe"

        expect(page).to have_content @animal.name
        expect(page).to have_content @animal.species
        expect(page).to have_content @animal.gender
        expect(page).to have_content @animal.age
        expect(page).to have_content @animal.size
      end

      scenario "User clicks 'See More'" do
        click_link "See More"

        expect(page).to have_content @animal.name
        expect(page).to have_content @animal.species
        expect(page).to have_content @animal.gender
        expect(page).to have_content @animal.age
        expect(page).to have_content @animal.size
      end
    end
  end
end
