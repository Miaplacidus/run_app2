class Challenge < ActiveRecord::Base
  belongs_to :post
  # Differentiate between sender and recipient
  belongs_to :sender, class_name: "Circle", foreign_key: "sender_id"
  belongs_to :recipient, class_name: "Circle", foreign_key: "recipient_id"
end
