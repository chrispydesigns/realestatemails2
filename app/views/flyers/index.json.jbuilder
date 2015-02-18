json.array!(@flyers) do |flyer|
  json.extract! flyer, :id, :name, :description, :content
  json.url flyer_url(flyer, format: :json)
end
