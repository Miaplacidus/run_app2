json.array!(@users) do |user|
  json.extract! user, :id, :first_name, :gender, :email, :bday, :rating, :fbid, :image, :level
  json.url user_url(user, format: :json)
end
