json.array!(@challenges) do |challenge|
  json.extract! challenge, :id, :name, :sender_id, :recipient_id, :post_id, :state, :notes
  json.url challenge_url(challenge, format: :json)
end
