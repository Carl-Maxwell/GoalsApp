FactoryGirl.define do
  factory :goal do
    name "Goal Name"
    completed false
    public_goal false
    association :user, factory: :user
  end
end
