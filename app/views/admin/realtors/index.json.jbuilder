json.array!(realtors) do |plan|
  json.extract! realtor, :id, :first_name, :last_name, :email
  json.url user_admin_url(realtor, format: :json)
end
