FactoryGirl.define do
  factory :user do
    username "Bob"
    password "password"

    # association :goals, factory: :goal

    factory :faker_user1 do
      username Faker::Internet.user_name
    end
    factory :faker_user2 do
      username Faker::Internet.user_name
    end
  end
end
