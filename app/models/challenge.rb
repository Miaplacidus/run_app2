class Challenge < ActiveRecord::Base
  enum state: [:pending, :rejected, :accepted, :completed]

  belongs_to :post
  belongs_to :sender, class_name: 'Circle', foreign_key: 'sender_id'
  belongs_to :recipient, class_name: 'Circle', foreign_key: 'recipient_id'

  validates_presence_of :name, :sender_id, :recipient_id

  scope :recently_sent_challenges, -> (circle_id) { where(sender_id: circle_id).where('updated_at > ?', 4.weeks.ago).order(:updated_at) }
  scope :recently_received_challenges, -> (circle_id) { where(recipient_id: circle_id).where('updated_at > ?', 4.weeks.ago).order(:updated_at) }
end
