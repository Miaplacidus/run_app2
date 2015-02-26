class CircleUser < ActiveRecord::Base
  belongs_to :circle
  belongs_to :user

  validate :max_members_reached?

  private

  def max_members_reached?
    if CircleUser.where(circle_id: circle_id).count >= 25
      errors.add(:max_members, 'circle has reached max number of members')
    end
  end
end
