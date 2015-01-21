class JoinRequest < ActiveRecord::Base
  enum state: [:pending, :rejected, :accepted]

  validates_presence_of :circle_id, :user_id

  belongs_to :user
  belongs_to :circle
end
