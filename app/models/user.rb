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

  validates_uniqueness_of :email

  scope :committed_to_run, lambda { |post_id| where(Post.where(id: post_id).first.commitments.pluck(:user_id)) }
  scope :run_attendees, lambda { |post_id| where(Post.where(id: post_id).first.commitments.where(fulfilled: true).pluck(:user_id) )}
  scope :requested_to_join_circle, lambda { |circle_id| where(JoinRequest.where(circle_id: circle_id).pluck(:user_id)) }

  def self.from_omniauth(auth)
    where(fbid: auth.uid).first_or_initialize.tap do |user|
      user.fbid = auth.uid
      user.first_name = auth.info.first_name
      user.img_url = auth.info.image
      user.email = auth.info.email
      user.bday = auth.extra.raw_info.birthday
      self.gender_id(user, auth.extra.raw_info.gender)

      user.save!
    end
  end

  def self.gender_id(user, gender)
    if gender == 'female'
        user.gender = 1
      elsif gender == 'male'
        user.gender = 2
      else
        user.gender = 0
      end
  end

  def self.nearby?(filters)
    #filters = { user_lat, user_long, post_lat, post_long }
    distance = Haversine.distance(filters[:user_lat], filters[:user_long], filters[:post_lat], filters[:post_long])
    if distance.to_mi <= 1
      return true
    else
      return false
    end
  end

  def get_user_age(id)
    bday = User.where(id: id).first.bday
    bday = bday.split('/')
    bday = DateTime.new(bday[2].to_i, bday[0].to_i, bday[1].to_i)
    age = (DateTime.now - bday) / 365.25

    case age
      when 18..23
        return 1
      when 23..30
        return 2
      when 30..40
        return 3
      when 40..50
        return 4
      when 50..60
        return 5
      when 60..70
        return 6
      when 70..80
        return 7
      when 80..110
        return 8
      else
        return nil
    end
  end

  def self.level(id)
    attended = Commitment.where("user_id = ? AND fulfilled = ?", id, true)
    ((attended.map { |commitment| Post.where(id: commitment.post_id).first }.map { |post| post.pace }.inject { |memo, n| memo + n })/attended.length).round
  end

  def self.rating(id)
    attended = Commitment.where("user_id = ? AND fulfilled = ?", id, true)
    total_commitments = attended.select { |commitment| Post.where(id: commitment.post_id).first.time < Time.now }.length
    return 0 if total_commitments == 0
    (attended/total_commitments*100).round
  end

end

=begin
GENDER
0 - Not Provided
1 - Female
2 - Male
=end
