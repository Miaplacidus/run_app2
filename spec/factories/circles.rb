# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :circle, aliases: [:sender, :recipient] do
    name    { Faker::Company.name + Faker::Company.suffix}
    # sequence(:location) { |n| "POINT(#{-87.6789658 + n*10**-7} #{41.9120736 - n*10**-7} )" }
    location "POINT(-87.6789658 41.9120736)"
    description { Faker::Lorem.paragraph }
    level { rand(0..8) }
    city    "Chicago, IL, USA"
    admin
  end
end
