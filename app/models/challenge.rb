class Challenge < ActiveRecord::Base
  belongs_to :post
  # Differentiate between sender and recipient
  belongs_to :sender, class_name: "Circle", foreign_key: "sender_id"
  belongs_to :recipient, class_name: "Circle", foreign_key: "recipient_id"

  scope :get_sent_challenges, lambda { |id| where(id: id).first.sent_challenges.order(:created_at) }
  scope :get_rec_challenges, lambda { |id| where(id: id).first.received_challenges.order(:created_at) }
end
