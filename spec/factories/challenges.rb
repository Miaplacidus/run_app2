# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :challenge do
    name "Kick ass"
    sender_id 1
    recipient_id 1
    post_id 1
    state "pending"
    notes "Meet up at the park and run like mad."
  end
end
