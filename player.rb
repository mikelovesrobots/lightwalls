class Player
  attr_accessor :game_state

  def update(game_state)
    self.game_state = game_state
  end

  def character
    "@"
  end

  def self.descendents
    result = []
    ObjectSpace.each_object(Class) do |klass|
      result << klass if klass < Player
    end
    result
  end
end
