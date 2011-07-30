class StraightLinePlayer < Player
  def update(packet)
    packet.move = :down
  end
end
