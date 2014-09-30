class CircleUser < ActiveRecord::Base
  belongs_to :circle
  belongs_to :user

  def self.is_member?(user_id, circle_id)
    membership = CircleUsers.where("circle_id = ? AND user_id = ?", circle_id, user_id).first
    membership != nil
  end
end
