json.array!(@commitments) do |commitment|
  json.extract! commitment, :id, :amount, :fulfilled, :post_id, :user_id
  json.url commitment_url(commitment, format: :json)
end
