class Round < OhmBaseModel
  reference :game, :Game
  collection :balls, :Ball
  collection :shots, :Shot
end
