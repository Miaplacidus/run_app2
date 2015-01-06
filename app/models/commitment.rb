class Commitment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  # validations: should never allow commitments to be created when the maximum number of runners
  # has been reached for the corresponding post

  scope :post_commit, lambda { |user_id, post_id| where("user_id = ? AND post_id = ?", user_id, post_id).first }
  scope :user_commits, lambda { |user_id| where(user_id: user_id) }
end
