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
  let(:user) { create(:user) }

  it "shows username on the homepage after login" do
    visit(new_session_url)
    fill_in("username", with: user.username)
    fill_in("password", with: user.password)
    click_button("Sign In")
    expect(page).to have_content(user.username)
  end

end

feature "logging out" do
  let(:user) { create(:user) }

  it "begins with logged out state" do
      visit(root_url)
      expect(page).to have_no_content(user.username)
  end

  it "doesn't show username on the homepage after logout" do
    visit(new_session_url)
    fill_in("username", with: user.username)
    fill_in("password", with: user.password)
    click_button("Sign In")
    expect(page).to have_content(user.username)

    click_button("Sign Out")

    expect(page).to have_no_content(user.username)
  end

end
