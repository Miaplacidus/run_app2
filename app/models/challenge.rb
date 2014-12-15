class Challenge < ActiveRecord::Base
  belongs_to :post
  belongs_to :sender, class_name: "Circle", foreign_key: "sender_id"
  belongs_to :recipient, class_name: "Circle", foreign_key: "recipient_id"

end
# A challenge can be in one of 3 states: pending, rejected, and accepted
