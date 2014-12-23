json.array!(@posts) do |post|
  json.extract! post, :id, :circle_id, :organizer_id, :time, :location, :pace, :notes, :complete, :min_amt, :age_pref, :gender_pref, :max_runners, :min_distance, :address
  json.url post_url(post, format: :json)
end
