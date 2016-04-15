json.array!(@item_checkins) do |item_checkin|
  json.extract! item_checkin, :id, :quantity_checkedin, :quantity_remaining, :unit_price, :donated, :checkin_date, :item_id
  json.url item_checkin_url(item_checkin, format: :json)
end
