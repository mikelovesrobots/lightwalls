class GamePacket
  attr_accessor :x, :y, :move, :map

  VALID_DIRECTIONS = [:left, :right, :up, :down]

  def initialize(x, y, map)
    self.x = x
    self.y = y
    self.map = map.freeze
  end

  def move=(value)
    if VALID_DIRECTIONS.include? value
      @move = value
    else
      raise ArgumentError, "Unknown value #{value.inspect} stored in move"
    end
  end
end
