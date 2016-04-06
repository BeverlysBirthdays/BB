json.array!(@bins) do |bin|
  json.extract! bin, :id, :checkout_date
  json.url bin_url(bin, format: :json)
end
