class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

# If we created a play method in the Bingo class it would simply override the Game#play
# method whenever play is called from a Bingo object.