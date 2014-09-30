# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :commitment do
    amount 1.5
    fulfilled false
    post_id 1
    user_id 1
  end
end
