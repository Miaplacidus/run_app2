# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user, aliases: [ :organizer, :admin ] do
    first_name "Sophie"
    gender 1
    email  { Faker::Internet.email }
    bday "03/14/1987"
    rating 1.5
    fbid "3737g7d88js"
    img_url "some_img.jpg"
    level 1
  end
end
