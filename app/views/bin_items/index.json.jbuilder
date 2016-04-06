json.array!(@bin_items) do |bin_item|
  json.extract! bin_item, :id, :quantity, :item_id, :bin_id
  json.url bin_item_url(bin_item, format: :json)
end
