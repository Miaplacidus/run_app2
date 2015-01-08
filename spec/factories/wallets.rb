# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :wallet do
    user
    balance 1.5
  end
end
