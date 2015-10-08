require "rails_helper"

feature "user can add an animal", %{
  As a user
  I want to add an animal
  So other users can see it

  Acceptance Criteria
  [x] - User must be signed in
  [x] - User must have a rescue account
  [x] - User can navigate to the add an animal form from their show page
  [x] - User should see the form displayed correctly
  [x] - User must provide the animals name, species, gender, size, and age and
        optionally a description
  [x] - User should be notified of failure if their animal hasn't been saved
  [x] - User should be notified of success if their animal has been saved
  [x] - User should see their updated information on their show page

} do
  feature "User adds an animal" do
    before(:each) do
      @user = FactoryGirl.create(:user, rescue_group: true)
      visit new_user_session_path
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_button "Log in"
      visit user_path(@user)
    end

    scenario "User navigates to the add an animal page from their show page" do
      click_link "Add an animal"

      expect(page).to have_content "Add a new animal"
    end

    scenario "Non-rescue accounts can't add an animal" do
      expect(page).to_not have_content "Add a new animal"
    end

    scenario "User sees the add an animal form diplayed correctly" do
      click_link "Add an animal"

      expect(page).to have_content "Add a new animal"
      expect(page).to have_content "Species"
      expect(page).to have_content "Gender"
      expect(page).to have_content "Size"
      expect(page).to have_content "Age"
      expect(page).to have_content "Description"
      expect(page).to have_content "Photo"
    end

    feature "User fills out form correctly" do
      scenario "User sees notification of success" do
        click_link "Add an animal"

        fill_in "Name", with: "Petie"
        select "Dog", from: "Species"
        select "Male", from: "Gender"
        select "Extra Small: under 10lbs", from: "Size"
        select "1-3 years", from: "Age"
        select "Yes", from: "Are they spayed or neutered?"
        select "Yes", from: "Are they good with dogs?"
        select "Yes", from: "Are they good with cats?"
        select "Yes", from: "Are they good with kids?"
        attach_file "Photo",
                    "#{Rails.root}/spec/support/images/default-profile.jpeg"
        fill_in "Description", with: "Very friendly!  Loves to play fetch."
        click_button "Add"

        animal = Animal.last
        expect(page).to have_xpath(
          "//img[@src=\"/uploads/animal/animal_photo/#{animal.id}/default-profile.jpeg\"]")
        expect(animal.animal_photo.file.filename).to eq("default-profile.jpeg")
        expect(page).to have_content "Petie has been added!"
        expect(page).to have_content "Very friendly!  Loves to play fetch."
      end
    end

    feature "User does not fill in the form correctly and is presented with errors" do
      scenario "User does not provide a name or an age" do
        click_link "Add an animal"

        select "Dog", from: "Species"
        select "Male", from: "Gender"
        select "Extra Small: under 10lbs", from: "Size"
        click_button "Add"

        expect(page).to have_content "Name can't be blank"
      end
    end
  end
end
