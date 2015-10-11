require "rails_helper"

feature "user accepts foster offer", %{
  As a user
  I want to accept a foster offer
  So that other users know that animal needs a foster

  Acceptance Criteria
  [x] - User must be an animal rescue
  [x] - User should not see the foster offers if they are not the rescue
  [x] - User should see a list of foster offers on the animal's show page
  [x] - User should see notification of success after they accept the foster
        offer
  [x] - User should no longer see an animal in the index page if they have a
        foster
} do
  feature "Users are created" do
    before(:each) do
      @rescue_group = FactoryGirl.create(:user, rescue_group: true)
      @foster = FactoryGirl.create(:user, rescue_group: false)
      @animal = FactoryGirl.create(:animal, animal_rescue_id: @rescue_group.id)
      FosterOffer.create!(animal_id: @animal.id, user_id: @foster.id,
                          animal_rescue_id: @rescue_group.id)
    end

    feature "User is signed in but not a rescue" do
      scenario "User does see foster offers" do
        visit new_user_session_path
        fill_in "Email", with: @foster.email
        fill_in "Password", with: @foster.password
        click_button "Log in"
        click_button "Foster Me"
        click_link @animal.name

        expect(page).to_not have_content "These users have offered to foster Roscoe"
      end
    end

    feature "User is signed in as a rescue" do
      scenario "User sees foster offers" do
        visit new_user_session_path
        fill_in "Email", with: @rescue_group.email
        fill_in "Password", with: @rescue_group.password
        click_button "Log in"

        click_link @animal.name
        expect(page).to have_content "These users have offered to foster Roscoe"
        expect(page).to have_button "Accept Foster"
      end
    end

    feature "User accepts foster offfer" do
      scenario "User no longer sees animal in index page" do
        visit new_user_session_path
        fill_in "Email", with: @rescue_group.email
        fill_in "Password", with: @rescue_group.password
        click_button "Log in"

        click_link @animal.name
        click_button "Accept Foster"
        click_link @rescue_group.email
        click_link "Foster Network"
        expect(page).to_not have_content @animal.name
      end

      scenario "User recieves an email letting them know that the offer was
        accepted" do
        visit new_user_session_path
        fill_in "Email", with: @rescue_group.email
        fill_in "Password", with: @rescue_group.password
        click_button "Log in"

        click_link @animal.name
        click_button "Accept Foster"
        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end
    end
  end
end
