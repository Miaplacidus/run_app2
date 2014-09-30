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
end

=begin
GENDER
0 - Not Provided
1 - Female
2 - Male
=end
