# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    circle_id 1
    organizer_id 1
    time "2014-09-29 20:32:51"
    location "POINT(#{-87.6789658} #{41.9120736})"
    pace 1
    notes "No crying."
    complete false
    min_amt 1.5
    age_pref 1
    gender_pref 1
    max_runners 1
    min_distance 1
    address "123 Marathon Blvd, Chicago, IL 60647"
  end
end
