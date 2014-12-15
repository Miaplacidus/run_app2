# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'factory_girl'

case Rails.env
  when 'development'
    Challenge.delete_all
    Circle.delete_all
    CircleUser.delete_all
    Commitment.delete_all
    JoinRequest.delete_all
    Post.delete_all
    PostUser.delete_all
    User.delete_all
    Wallet.delete_all

    FactoryGirl.define do
      factory :challenge do
        name    { Faker::Company.catch_phrase }
        sender
        recipient
        post
        state { ["pending", "accepted", "rejected"].sample }
        notes { Faker::Lorem.paragraph }
      end

      factory :circle, aliases: [:sender, :recipient] do
        name    { Faker::Company.name }
        max_members { [5, 15, 30, 60].sample }
        sequence(:location) { |n| "POINT(#{-87.6789658 + n*10**-7} #{41.9120736 + n*10**-7} )" }
        description { Faker::Lorem.paragraph }
        level { rand(0..8) }
        city    "Chicago"
        admin
      end

      factory :commitment do
        amount { [0, 5, 10, 15, 20].sample }
        fulfilled { [true, false].sample }
        post
        user
      end

      factory :join_request do
        circle
        user
        accepted    { [true, false].sample }
      end

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
        max_runners { [2, 5, 8, 11, 14].sample }
        min_distance { [1, 3, 5, 10, 15].sample }
        sequence(:location) { |n| "POINT(#{-87.6789658 + n*10**-7} #{41.9120736 + n*10**-7} )" }
        # address { Geocoder.address([location.latitude, location.longitude]) }
        address "some address"
      end

      factory :user, aliases: [:organizer, :admin] do
        first_name    { Faker::Name.first_name }
        gender    { rand(0..2)}
        email   { Faker::Internet.email }
        bday   { Faker::Date.between(70.years.ago, Date.today) }
        fbid    { Faker::Code.ean }
        img_url   "http://dims.vetstreet.com/dims3/MMAH/thumbnail/590x420/quality/90/?url=http%3A%2F%2Fs3.amazonaws.com%2Fassets.prod.vetstreet.com%2F5b%2Ff9%2F6fd60f5e406d89d49934d1f75104%2Fgrumpy-cat-590sm121812.jpg"
      end

      factory :wallet do
        user
        balance     { rand(0.0..100.0) }
      end
    end

    FactoryGirl.create_list(:user, 5)
    FactoryGirl.create_list(:wallet, 5)
    FactoryGirl.create_list(:circle, 10)
    FactoryGirl.create_list(:post, 15)
    FactoryGirl.create_list(:join_request, 5)
    FactoryGirl.create_list(:challenge, 5)
    FactoryGirl.create_list(:commitment, 5)
end
