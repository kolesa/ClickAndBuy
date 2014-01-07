json.array!(@shops) do |shop|
  json.extract! shop, :name, :desc, :url, :fb, :vk, :avatar
  json.url shop_url(shop, format: :json)
end