# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :join_request do
    circle
    user
    state { ["pending", "accepted", "rejected"].sample }
  end
end
