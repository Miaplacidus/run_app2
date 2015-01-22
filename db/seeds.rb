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
    User.delete_all
    Wallet.delete_all

    FactoryGirl.define do
      factory :challenge do
        name    { Faker::Company.catch_phrase }
        sender
        recipient
        post
        state { ["pending", "accepted", "rejected", "completed"].sample }
        notes { Faker::Lorem.paragraph }
      end

      factory :circle, aliases: [:sender, :recipient] do
        name    { Faker::Company.name }
        description { Faker::Lorem.paragraph }
        level { rand(0..8) }
        city    "Chicago, IL, USA"
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
        state { ["pending", "accepted", "rejected"].sample }
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
        max_runners { [4, 7, 11, 14].sample }
        min_distance { [1, 2, 3, 5, 9, 13, 17, 22, 26].sample }
        sequence(:location) { |n| "POINT(#{-87.6789658 + n*10**-6} #{41.9120736 + n*10**-7} )" }
        before(:create) { |post| post.update(address: Geocoder.address([post.location.latitude, post.location.longitude])) }
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

    FactoryGirl.create_list(:user, 3)
    FactoryGirl.create_list(:wallet, 3)
    FactoryGirl.create_list(:circle, 5)
    FactoryGirl.create_list(:post, 10)
    FactoryGirl.create_list(:join_request, 5)
    FactoryGirl.create_list(:challenge, 3)
    FactoryGirl.create_list(:commitment, 3)
end
