# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :join_request do
    cicle_id 1
    user_id 1
    accepted false
  end
end
