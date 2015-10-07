# require "rails_helper"
#
# feature "user can edit an animal", %{
#   As a user
#   I want to edit an animal
#   So other users can see the correct details about that animal
#
#   Acceptance Criteria
#   [] - User must be signed in
#   [] - User can navigate to the update an animal form from their show page
#   [] - User should see a link next to the animal to access the update page
#   [] - User should see the form displayed correctly
#   [] - User should be notified of failure if their animal hasn't been saved
#   [] - User should be notified of success if their animal has been saved
#   [] - User should see their updated information on their show page
#
# } do
#   feature "User adds an animal" do
#     before(:each) do
#       @user = FactoryGirl.create(:user, rescue_group: true)
#       @animal = FactoryGirl.create(:animal, animal_rescue_id: @user.id)
#       visit new_user_session_path
#       fill_in "Email", with: @user.email
#       fill_in "Password", with: @user.password
#       click_button "Log in"
#     end
#
#     scenario "User navigates to the update an animal page from their show page" do
#       click_link "Update"
#
#       expect(page).to have_content "Update Roscoe"
#     end
#
#     scenario "User sees the update an animal form diplayed correctly" do
#       click_link "Update"
#
#       expect(page).to have_content "Update Roscoe"
#       expect(page).to have_content "Name"
#       expect(page).to have_content "Species"
#       expect(page).to have_content "Gender"
#       expect(page).to have_content "Size"
#       expect(page).to have_content "Age"
#       expect(page).to have_content "Description"
#     end
#
#     feature "User fills out form correctly" do
#       scenario "User sees notification of success" do
#         click_link "Add an animal"
#
#         fill_in "Name", with: "Petie"
#         select "Dog", from: "Species"
#         select "Male", from: "Gender"
#         select "Extra Small: under 10lbs", from: "Size"
#         select "1-3 years", from: "Age"
#         select "Yes", from: "Are they spayed or neutered?"
#         select "Yes", from: "Are they good with dogs?"
#         select "Yes", from: "Are they good with cats?"
#         select "Yes", from: "Are they good with kids?"
#         fill_in "Description", with: "Very friendly!  Loves to play fetch."
#         click_button "Add"
#
#         expect(page).to have_content "Petie has been added!"
#         expect(page).to have_content "Very friendly!  Loves to play fetch."
#       end
#     end
#
#     feature "User does not fill in the form correctly and is presented with errors" do
#       scenario "User does not provide a name or an age" do
#         click_link "Add an animal"
#
#         select "Dog", from: "Species"
#         select "Male", from: "Gender"
#         select "Extra Small: under 10lbs", from: "Size"
#         click_button "Add"
#
#         expect(page).to have_content "Name can't be blank"
#       end
#     end
#   end
# end
