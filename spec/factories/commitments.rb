# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :commitment do
    amount { [0, 5, 10, 15, 20].sample }
    fulfilled false
    post
    user
  end
end
