words = File.readlines("dictionary.txt", chomp: true)
secret_words = words.select do |line|
  line if line.length > 4 && line.length < 13
end

class Game
  def guess

  end
end

class player
  def initialize(name)
    @name = name
    @guess_count = 0
    
end
# algs 
#  create a game class
#  create a player class to store the player's states
#  create a guess method on game class
#  
# 
# 
# 