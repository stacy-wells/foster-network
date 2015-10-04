require "rails_helper"

feature "user registers", %{
  As a visitor
  I want to register
  So that I can create an account
} do
  # Acceptance Criteria:
  # * I must specify a valid email address,
  #   password, and password confirmation
  # * If I don't specify the required information, I am presented with
  #   an error message

  scenario "provide valid registration information" do
    visit new_user_registration_path

    fill_in "Email", with: "john@example.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    fill_in "First Name", with: "Leslie"
    fill_in "Last Name", with: "Knope"
    fill_in "City", with: "Pawnee"
    fill_in "State", with: "IN"
    choose("Foster")

    click_button "Sign up"

    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(page).to have_content("Sign Out")
  end

  scenario "provide invalid registration information" do
    visit new_user_registration_path

    click_button "Sign up"
    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Sign Out")
  end
end