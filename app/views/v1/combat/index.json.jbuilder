json.winner do
  json.hero @combat.winner
  json.won_by @combat.won_by
  json.word @combat.winning_word
end

json.meta do
  json.total_combats @combat.total_combats
  json.seed_number @combat.seed_number
  json.players @combat.players
  json.messages @combat.errors
end
