# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name "MyString"
    gender 1
    email "MyString"
    bday "MyString"
    rating 1.5
    fbid "MyString"
    image "MyString"
    level 1
  end
end
