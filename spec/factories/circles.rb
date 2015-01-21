# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :circle, aliases: [:sender, :recipient] do
    name    { Faker::Company.name + Faker::Company.suffix}
    description { Faker::Lorem.paragraph }
    level { rand(0..8) }
    city    "Chicago, IL, USA"
    admin
  end
end
