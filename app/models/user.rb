class User < ActiveRecord::Base
  has_many :adm_circles, class_name:"Circle"
  has_many :circle_users
  has_many :circles, :through => :circle_users
  has_many :commitments
  has_many :created_posts, class_name:"Posts", foreign_key:"creator_id"
  has_many :join_requests
  has_many :post_users
  has_many :posts, :through => :post_users
  has_one :wallet

  def self.from_omniauth(auth)
    where(fbid: auth.uid).first_or_initialize.tap do |user|
      user.fbid = auth.uid
      user.first_name = auth.info.first_name
      user.img_url = auth.info.image
      user.email = auth.info.email
      user.bday = auth.extra.raw_info.birthday
      fb_gender = auth.extra.raw_info.gender

      if fb_gender == 'female'
        user.gender = 1
      elsif fb_gender == 'male'
        user.gender = 2
      else
        user.gender = 0
      end

      user.save!
    end
  end

end

=begin
GENDER
0 - Not Provided
1 - Female
2 - Male
=end
