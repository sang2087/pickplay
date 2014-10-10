json.array!(@games) do |game|
  json.extract! game, :id, :name, :image, :genre_id, :device_ids
  json.url game_url(game, format: :json)
end
