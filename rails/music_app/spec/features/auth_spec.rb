require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign up page"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'Email (primary identifier)', :with => "testing@email.com"
      fill_in 'password', :with => "biscuits"
      fill_in 'Username (can be changed later!)', with: 'original'
      fill_in 'Confirm Password', with: 'biscuits'
      click_on "Create User!"
    end

    scenario "redirects to users page after signup" do
      expect(page).to have_content('original')
    end
  end

  feature "with an invalid user" do
    before(:each) do
      visit new_user_url
      fill_in 'Email (primary identifier)', :with => "testing@email.com"
      click_on "Create User!"
    end

    scenario "re-renders the signup page after failed signup" do
      expect(page).to have_content("Password can't be blank")
    end
  end

end
