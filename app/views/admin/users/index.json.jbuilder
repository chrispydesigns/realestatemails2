json.array!(users) do |plan|
  json.extract! user, :id, :first_name, :last_name, :email, :username
  json.url user_admin_url(user, format: :json)
end
