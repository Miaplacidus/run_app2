# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :circle do
    name "DevMynd"
    max_members 1
    location "POINT(#{-87.6789658} #{41.9120736})"
    description "We code. We run. We WIN."
    level 1
    city "Chi-Town"
    admin
  end
end
