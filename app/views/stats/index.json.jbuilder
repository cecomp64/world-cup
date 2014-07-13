json.array!(@stats) do |stat|
  json.extract! stat, :id, :title, :key
  json.url stat_url(stat, format: :json)
end
