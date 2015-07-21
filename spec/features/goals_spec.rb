require 'spec_helper'
require 'rails_helper'
require 'support/goals_support.rb'
require 'byebug'

feature "create" do
  let (:user) { create(:user) }

  it "shows goal" do
    sign_in_user(user.username, user.password)
    visit(new_user_goal_url(user))
    fill_in("name", with: "do stuff")
    click_button("Create Goal")

    expect(page).to have_content("do stuff")
  end
end

feature "read" do
  let (:goal) { create(:goal) }

  it "displays goal" do
    sign_in_user(goal.user.username, goal.user.password)
    visit(goal_url(goal))
    expect(page).to have_content(goal.name)
  end
end

feature "update" do
  let (:goal) { create(:goal) }

  it "changes goal name after the update" do
    sign_in_user(goal.user.username, goal.user.password)
    visit(edit_goal_url(goal))
    fill_in("name", with: "this is updated name")
    click_button("Update Goal")

    expect(page).to have_content("this is updated name")
  end
end

feature "destroy" do
  let (:goal) { create(:goal) }

  it "removes the goal from the index" do
    sign_in_user(goal.user.username, goal.user.password)
    visit(goal_url(goal))
    click_button("Delete Goal")

    expect(page).to_not have_content(goal.name)
  end
end

feature "private / public" do
  let (:user1) { create(:faker_user1) }
  let (:user2) { create(:faker_user2) }

  it "hides private goals" do
    create_goal_for_user(user1, false)

    sign_in_user(user2.username, user2.password)

    visit(user_goals_url(user1))

    expect(page).to_not have_content(user1.goals.first.name)
  end

  it "shows public things to the public" do
    create_goal_for_user(user1, true)

    sign_in_user(user2.username, user2.password)

    visit(user_goals_url(user1))

    expect(page).to have_content(user1.goals.first.name)
  end
end

feature "completed" do
  let (:user1) { create(:faker_user1) }

  it "has a page just for incomplete tasks" do
    create_goal_for_user(user1, false, true)
    create_goal_for_user(user1, false, false)
    sign_in_user(user1.username, user1.password)

    visit(user_goals_url(user1, completed: :false))

    expect(page).to_not have_content(user1.goals.first.name)
    expect(page).to have_content(user1.goals.second.name)
  end

  it "has a page just for completed tasks" do
    create_goal_for_user(user1, true, true)
    create_goal_for_user(user1, true, false)
    sign_in_user(user1.username, user1.password)

    visit(user_goals_url(user1, completed: :true))

    expect(page).to have_content(user1.goals.first.name)
    expect(page).to_not have_content(user1.goals.second.name)
  end

end
