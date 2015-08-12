json.array!(@foods) do |food|
  json.extract! food, :id, :name, :producer_id, :upc, :servings, :serving_size, :unit, :slug
  json.url food_url(food, format: :json)
end
