# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    circle
    organizer
    time "2014-09-29 20:32:51"
    location "POINT(#{-87.6789658} #{41.9120736})"
    pace 1
    notes "No crying."
    complete false
    min_amt 0
    age_pref 1
    gender_pref 1
    max_runners 2
    min_distance 1
    address "123 Marathon Blvd, Chicago, IL 60647"
    is_public true
  end
end
