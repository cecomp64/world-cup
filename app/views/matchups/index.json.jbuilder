json.array!(@matchups) do |matchup|
  json.extract! matchup, :id, :homeScore, :awayScore, :final
  json.url matchup_url(matchup, format: :json)
end
