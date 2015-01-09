# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user, aliases: [ :organizer, :admin ] do
    first_name { Faker::Name.first_name }
    gender { rand(0..2)}
    email  { Faker::Internet.email }
    bday "03/14/1987"
    rating 1.5
    fbid { Faker::Code.ean }
    img_url "some_img.jpg"
    level 1
  end
end
