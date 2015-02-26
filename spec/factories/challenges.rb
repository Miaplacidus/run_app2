# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :challenge do
    name    { Faker::Company.catch_phrase }
    sender
    recipient
    post
    state { %w(pending accepted rejected completed).sample }
    notes { Faker::Lorem.paragraph }
  end
end
