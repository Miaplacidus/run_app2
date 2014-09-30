class Post < ActiveRecord::Base
  has_many :commitments
  has_one :challenge
  # differentiate between creator and committers
  belongs_to :creator, class_name:"User", foreign_key:"creator_id"
  has_many :post_users
  has_many :users, :through => :post_users
  belongs_to :circle
end
