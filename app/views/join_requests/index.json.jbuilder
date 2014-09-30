json.array!(@join_requests) do |join_request|
  json.extract! join_request, :id, :cicle_id, :user_id, :accepted
  json.url join_request_url(join_request, format: :json)
end
