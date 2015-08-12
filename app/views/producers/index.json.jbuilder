json.array!(@producers) do |producer|
  json.extract! producer, :id, :name, :slug
  json.url producer_url(producer, format: :json)
end
