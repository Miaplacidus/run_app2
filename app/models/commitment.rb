class Commitment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validate :max_runners_reached?

  scope :post_commit, lambda { |user_id, post_id| where("user_id = ? AND post_id = ?", user_id, post_id).first }
  scope :user_commits, lambda { |user_id| where(user_id: user_id) }

  def max_runners_reached?
    if Commitment.where(post_id: post_id).count > Post.find(post_id).max_runners
      errors.add(:max_runners, "post has reached max num of runners")
    end
  end
end
