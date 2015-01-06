# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :circle do
    name "DevMynd"
    max_members 1
    latitude 1.5
    longitude 1.5
    description "We code. We run. We WIN."
    level 1
    city "Chi-Town"
    admin_id 1
  end
end
