# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    circle
    organizer
    time { Faker::Time.between(Time.now, 6.months.from_now) }
    pace { rand(0..8) }
    notes { Faker::Lorem.paragraph }
    complete { [true, false].sample }
    min_amt { [0, 5, 10, 15, 20].sample }
    age_pref { rand(0..8) }
    gender_pref { rand(0..2) }
    max_runners { [4, 7, 11, 14].sample }
    min_distance { [1, 2, 3, 5, 9, 13, 17, 22, 26].sample }
    # sequence(:location) { |n| "POINT(#{-87.6789658 + n*10**-6} #{41.9120736 + n*10**-7} )" }
    location "POINT(-87.6789658 41.9120736)"
    is_public { [true, false].sample }
  end
end
