json.array!(@game_infos) do |game_info|
  json.extract! game_info, :id, :game_id, :maker, :distribute, :date, :class, :movie, :content
  json.url game_info_url(game_info, format: :json)
end
