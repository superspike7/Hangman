
class Game

  attr_reader :secret_word, :guess_tally, :miss_tally, :current_guess, :current_display

  def initialize
    @guess_tally = []
    @miss_tally = []
    @secret_word = self.generate_secret_word
    @current_display = '_'*secret_word.length
  end
  
  def guess_word
    puts "Guess:"
    @current_guess = gets.chomp.to_s.downcase
    guess_checker(current_guess)
  end

  def generate_secret_word
    words = File.readlines("dictionary.txt", chomp: true)
    secret_words = words.select { |line| line.length > 4 && line.length < 13}.sample
  end

  def display_stat
    puts "Word: #{display_guess}"
    puts "Misses: #{miss_tally}"
  end

  def guess_checker(letter)
    if secret_word.include? letter
      guess_tally << letter
    else
      miss_tally << letter
    end
  end
      
# fix this fucking current display shit
  def display_guess
      @current_display = secret_word.split('').map do |letter|
        secret_word.select { |letter| }
        end
      end.join(' ').upcase
      current_display
  end

  def win?
    secret_word.length == guess_tally.length
  end

end





def play_game
new_game = Game.new
round = 0
puts "let's play!, The word has been set!"
puts "word: #{new_game.current_display}"

  loop do
    new_game.guess_word
    new_game.display_stat
    break if new_game.win? || round == 8
    round += 1
  end
  puts "the correct answer is #{new_game.secret_word}"
  puts new_game.win? ? "you win! congrats!" : "you ran out of guesses, better luck next time"
end

play_game