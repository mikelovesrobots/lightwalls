class Battle
  attr_accessor :map, :players, :player_locations

  def initialize(map, players)
    self.player_locations = {}
    self.map = map
    self.players = players
    players.each do |player|
      place_player(player, get_free_location(map))
    end
  end

  def place_player(player, destination)
    self.player_locations[player] = destination
    map[destination.first, destination.last].character = player.character
  end

  def get_free_location(map)
    location = [rand(map.num_cols), rand(map.num_rows)]
    if self.map[location.first, location.last].empty?
      location
    else
      get_free_location(map)
    end
  end

  def fight!
    while players.length > 1
      player_list = players.dup

      player_list.each do |player|
        begin
          packet = GamePacket.new(player_locations[player].first, player_locations[player].last, map)
          player.update(packet)
          move(player, packet.move)
        rescue StandardError => e
          puts e.inspect
          puts e.backtrace.join("\n")
          kill(player)
        end

        map.print
      end
    end

    puts "#{players.first.class} is the winner!"
  end

  def move(player, move)
    clear_screen
    source = player_locations[player]

    case move
    when :left
      destination = [source.first - 1, source.last]
    when :right
      destination = [source.first + 1, source.last]
    when :up
      destination = [source.first, source.last - 1]
    when :down
      destination = [source.first, source.last + 1]
    else
      raise PlayerMoveError, "player didn't move"
    end

    if map.is_valid_move?(destination.first, destination.last)
      place_player(player, destination)
    else
      raise PlayerCrashError, "player crashed"
    end
  end

  def kill(player)
    players.reject! { |p| p == player }
  end

  def clear_screen
    puts "\e[H\e[2J"
  end

end

class PlayerMoveError < StandardError
end

class PlayerCrashError < StandardError
end

