# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :circle do
    name "MyString"
    max_members 1
    latitude 1.5
    longitude 1.5
    description "MyText"
    level 1
    city "MyString"
    admin_id 1
  end
end
