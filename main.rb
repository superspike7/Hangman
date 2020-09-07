
class Game

  attr_reader :secret_word, :guess_tally, :miss_tally, :current_display
  attr_accessor :current_guess

  def initialize
    @guess_tally = []
    @miss_tally = []
    @secret_word = self.generate_secret_word
    @current_display = '_'*secret_word.length
  end
   
  def prompt(user_guess=nil)
    @current_guess = user_guess
    guess_check
    update_tally
    update_stat
  end

  def generate_secret_word
    words = File.readlines("dictionary.txt", chomp: true)
    secret_words = words.select { |line| line.length > 4 && line.length < 13}.sample
  end

  def display_stat
    puts "Word: #{current_display}"
    puts "Misses: #{miss_tally.join(' ')}"
  end

  def guess_check
    if current_guess == nil
      'papi'
    elsif current_guess == 'save'
      'save'
    elsif secret_word.include? current_guess
      true
    else
      false
    end
  end

  def update_tally
    guess_check == true ? @guess_tally << current_guess : @miss_tally << current_guess
  end
      
  def update_stat
   arr = current_display.split('')
   secret_word.split('').each_with_index do |letter, index|
    arr[index] = secret_word[index] if guess_tally.length > 0 && letter == current_guess
   end
   @current_display = arr.join('')
  end

  def win?
   current_display == secret_word
  end
end

def save(gamefile)
  File.open('game', 'w+') do |f|
    Marshal.dump(gamefile, f)
  end
end

def load
  File.open('game') do |f|
    loaded_game = Marshal.load(f)
  end
end


def prompt_user(obj)
  print "guess: "
  ans = gets.chomp.to_s.downcase
  if ans == 'save'
    save(obj)
    obj.current_guess = 'save'
  else
    obj.prompt(ans)
  end
end


def play_game(game=default_game = Game.new)
  puts "let's play!, The word has been set!"
  puts "word: #{game.current_display}"
  remaining_guess = game.miss_tally.count

  loop do
    prompt_user(game)
    game.display_stat
    break if game.current_guess == 'save' || game.win? || remaining_guess == 12 
    puts "remaining guess: #{12 - remaining_guess}" 
    remaining_guess += 1 if game.guess_check == false
  end

  unless game.guess_check == 'save'
    puts "the correct answer is #{game.secret_word}"
    puts game.win? ? "you win! congrats!" : "you ran out of guesses, better luck next time"
  else
    puts "game is saved"
  end

end

saved_game = load

puts "Do you want to make a (new) game or (load) a saved file?"
ans = gets.chomp.to_s
if ans == 'load'
  play_game(saved_game)
elsif ans == 'new'
  play_game
else
  puts "you must choose between (new) and (load)"
end