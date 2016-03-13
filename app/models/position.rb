class Position < OhmBaseModel
  reference :shot, :Shot
  reference :ball, :Ball
  attribute :x, Type::Float
  attribute :y, Type::Float
end
