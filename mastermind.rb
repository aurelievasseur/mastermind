class Code
  attr_accessor :code_to_crack

  @@color_list = %w[blue orange green violet yellow pink]
  def self.color_list
    @@color_list
  end

  def initialize
    @code_to_crack = Array.new(4, "none")
  end

  def generate_random_code
    @code_to_crack.each_with_index do |_value, index|
      @code_to_crack[index] = @@color_list[rand(0..5)]
    end
  end
end

class Game
  attr_reader :code, :guessed_code, :correct_all, :correct_color
  @@max_rounds = 12

  def initialize
    @round_number = 0
  end

  def create_code
    @code = Code.new
    @code.generate_random_code
  end

  def guess_code
    until @round_number == 12 || @code.code_to_crack == @guessed_code do
      puts "Here are the available colors :\n #{Code.color_list}"
      @round_number += 1
      puts "Round #{@round_number}: What is your guess?"
      @guessed_code = gets.chomp.split
      self.find_exact_matches(@code.code_to_crack, @guessed_code)
    end
    pp @code.code_to_crack
  end

  def find_exact_matches(code, guess)
    @temp_code = code.clone
    @correct_color = 0
    @correct_all = 0
    code.each_with_index do |val_code, index_code|
      if guess[index_code] == val_code
        @correct_all += 1
        @temp_code[index_code] = ""
      end

      if guess.any?{|color| color == @temp_code[index_code]}
        @correct_color += 1
        @temp_code[index_code] = ""
      end
    end
    pp "There are #{@correct_all} correct guesses"
    pp "There are #{@correct_color} correct colors at the wrong location"
  end

end

game = Game.new
game.create_code
game.guess_code

# pp game.code.code_to_crack
# pp game.guessed_code
# game.find_exact_matches(game.code.code_to_crack, game.guessed_code)



