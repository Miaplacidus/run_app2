# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    circle_id 1
    organizer_id 1
    time "2014-09-29 20:32:51"
    latitude 1.5
    longitude 1.5
    pace 1
    notes "MyText"
    complete false
    min_amt 1.5
    age_pref 1
    gender_pref 1
    max_runners 1
    min_distance 1
    address "MyString"
  end
end
