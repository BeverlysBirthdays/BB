json.array!(@item_checkin_archives) do |item_checkin_archive|
  json.extract! item_checkin_archive, :id, :quantity_checkedin, :unit_price, :donated, :checkin_date, :item_id
  json.url item_checkin_archive_url(item_checkin_archive, format: :json)
end
