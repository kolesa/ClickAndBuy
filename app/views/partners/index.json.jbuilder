json.array!(@partners) do |partner|
  json.extract! partner, :company, :type, :text, :name, :phone, :email, :url
  json.url partner_url(partner, format: :json)
end