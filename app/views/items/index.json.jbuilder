json.array!(@items) do |item|
  json.extract! item, :name, :desc, :published, :price
  json.url item_url(item, format: :json)
end