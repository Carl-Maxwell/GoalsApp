def sign_in_user(username, password)
  visit(new_session_url)
  fill_in("username", with: username)
  fill_in("password", with: password)
  click_button("Sign In")
end

def create_goal_for_user(user, public_goal, completed = false)
  user.goals.create(
    completed: completed,
    public_goal: public_goal,
    name: Faker::Hacker.say_something_smart
  )
end
