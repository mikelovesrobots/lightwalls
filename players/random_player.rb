class RandomPlayer < Player
  def update(packet)
    packet.move = random_move(packet)
  end

  def random_move(packet)
    valid_moves = packet.map.valid_moves(packet.x, packet.y)
    valid_moves[rand(valid_moves.length)]
  end
end
