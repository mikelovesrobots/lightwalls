class Terrain
  attr_accessor :character, :x, :y

  def initialize(x, y)
    self.x = x
    self.y = y
  end

  def empty?
    self.character.nil?
  end

  def to_s
    self.character || '.'
  end
end
