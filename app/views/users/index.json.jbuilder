json.array!(@users) do |user|
  json.extract! user, :id, :username, :email, :comments, :created_at, :updated_at
  json.url user_url(user, format: :json)
end
