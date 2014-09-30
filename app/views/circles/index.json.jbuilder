json.array!(@circles) do |circle|
  json.extract! circle, :id, :name, :max_members, :latitude, :longitude, :description, :level, :city, :admin_id
  json.url circle_url(circle, format: :json)
end
