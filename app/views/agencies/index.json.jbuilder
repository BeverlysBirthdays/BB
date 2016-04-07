json.array!(@agencies) do |agency|
  json.extract! agency, :id, :name, :active
  json.url agency_url(agency, format: :json)
end
