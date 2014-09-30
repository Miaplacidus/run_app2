# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :challenge do
    name "MyString"
    sender_id 1
    recipient_id 1
    post_id 1
    state "MyString"
    notes "MyText"
  end
end
