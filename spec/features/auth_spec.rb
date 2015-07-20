# spec/features/auth_spec.rb

require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content("Sign Up")
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      visit(new_user_url)
      fill_in("username", with: "Bob Harris")
      fill_in("password", with: "something else")
      click_button("Sign Up")
      expect(page).to have_content("Bob Harris")
    end

  end

end

feature "logging in" do

  it "shows username on the homepage after login" do

  end

end

feature "logging out" do

  it "begins with logged out state"

  it "doesn't show username on the homepage after logout"

end
