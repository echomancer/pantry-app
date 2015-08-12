json.array!(@stocks) do |stock|
  json.extract! stock, :id, :store_id, :food_id, :price, :quantity, :discount, :bought, :user_id, :slug, :remaining
  json.url stock_url(stock, format: :json)
end
