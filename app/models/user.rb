class User < ActiveRecord::Base
  has_many :adm_circles, class_name:"Circle"
  has_many :circle_users
  has_many :circles, :through => :circle_users
  has_many :commitments
  has_many :created_posts, class_name:"Posts", foreign_key:"organizer_id"
  has_many :join_requests
  has_many :post_users
  has_many :posts, :through => :post_users
  has_one :wallet

  enum gender: [:unspecified, :female, :male]
  validates_uniqueness_of :email

  scope :committed_to_run, -> (post_id) { where(Post.where(id: post_id).first.commitments.pluck(:user_id)) }
  scope :run_attendees, -> (post_id) { where(Post.where(id: post_id).first.commitments.where(fulfilled: true).pluck(:user_id) )}
  scope :requested_to_join_circle, -> (circle_id) { where(JoinRequest.where(circle_id: circle_id).pluck(:user_id)) }
  scope :nearby, -> (filters) { where("ST_Distance(location, 'POINT(? ?)') < ?", filters[:user_lon], filters[:user_lat], 2) }

  scope :from_omniauth, -> (auth) {
    where(fbid: auth.uid).first_or_initialize.tap do |user|
      user.fbid = auth.uid
      user.first_name = auth.info.first_name
      user.img_url = auth.info.image
      user.email = auth.info.email
      user.bday = auth.extra.raw_info.birthday
      user.gender_id(user, auth.extra.raw_info.gender)

      user.save!
    end
  }

  def gender_id(user, gender)
    if gender == 'female'
      female!
    elsif gender == 'male'
      male!
    else
      unspecified!
    end
  end

# Maybe use enums here
  def get_user_age(id)
    bday = User.find(id).bday.split('/')
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

# Scope both of these; break out the calculation into pieces; make this act on the object, not the class
  def level
    # attended = Commitment.where("user_id = ? AND fulfilled = ?", id, true)
    # ((attended.map { |commitment| Post.where(id: commitment.post_id).first }.map { |post| post.pace }.inject { |memo, n| memo + n })/attended.length).round
    5
  end

  def rating
    # attended = Commitment.where("user_id = ? AND fulfilled = ?", id, true)
    # total_commitments = attended.select { |commitment| Post.where(id: commitment.post_id).first.time < Time.now }.length
    # return 0 if total_commitments == 0
    # (attended/total_commitments*100).round
    5
  end

end

=begin
GENDER
0 - Not Provided
1 - Female
2 - Male
=end
