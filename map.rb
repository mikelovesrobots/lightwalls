class Map
  attr_accessor :data, :num_rows, :num_cols

  def initialize(rows, cols)
    self.data = generate_map(rows, cols)
    self.num_rows = rows
    self.num_cols = cols
  end

  def generate_map(rows, cols)
    tiles = []
    cols.times do |x|
      tiles << rows.times.collect do |y|
        Terrain.new(x, y)
      end
    end
    tiles
  end

  def [](x, y)
    data[x] && data[x][y]
  end

  def on_map?(x,y)
    x >= 0 and y >=0 and x < num_cols and y < num_rows
  end

  def is_valid_move?(x,y)
    on_map?(x,y) and self[x,y].empty?
  end

  def valid_moves(x,y)
    GamePacket::VALID_DIRECTIONS.select do |dir|
      coordinate = coordinate_for_move(x,y,dir)
      is_valid_move?(coordinate.first, coordinate.last)
    end
  end

  def coordinate_for_move(x,y,move)
    case move
    when :left
      x -= 1
    when :right
      x += 1
    when :up
      y -= 1
    when :down
      y += 1
    end

    return [x,y]
  end

  def print
    num_cols.times do |x|
      row = []
      num_rows.times.collect do |y|
        row << self[x,y].to_s
      end
      puts row.join
    end
    nil
    sleep(0.1)
  end
end
