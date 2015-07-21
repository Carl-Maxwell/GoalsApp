FactoryGirl.define do
  factory :comment do
    body "MyString"
commentable_type "MyString"
commentable_id 1
author_id 1
  end

end
