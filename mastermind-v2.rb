require "pry"

class Code
    attr_reader :code 

    def computer_code
        @code = Array.new(4)
        @code.each_with_index {|item, index| @code[index] = rand(1..6)}
    end

    def human_code
        puts "Human, type your code. It has to have 4 numbers between 1 and 6"
        @code = gets.chomp.split()
        @code.each_with_index {|item, index| @code[index] = item.to_i}
    end
end

class Game
    
    def initialize
        @win = false
        @exact_match = 0 
        @approx_match = 0 
        @indices = []
        @round = 0
        @guess = []
        @code = []
    end

    def player_choice
        puts "Welcome to this game !\nDo you want to create the code (C) or guess the code (G) ?\nType your answer now. "
        @choice = gets.chomp
    end

    def new_game
        code = Code.new
        if @choice == "C"
            @code = code.human_code
        elsif @choice == "G"
            @code = code.computer_code
        else
            puts "Wrong input, please try again"
            self.player_choice
            self.new_game
        end
    end

    def check_code_against_guess
        @guess.each_with_index do
            |guess_el, guess_index|
            @code.each_with_index do 
                |code_el, code_index|
                if code_el == guess_el && code_index == guess_index
                    if @indices.include?(code_index)
                        @approx_match -= 1
                    end
                    @exact_match += 1
                    @indices << code_index
                    next
                end
                if code_el == guess_el && !@indices.include?(code_index)
                    @approx_match += 1
                    @indices << code_index
                    next
                end
            end
        end
        puts "Exact matches: #{@exact_match}\nIncorrect matches: #{@approx_match}"
    end

    def advance_rounds
        until @round == 12 || @win
            self.ask_for_guess
            self.check_code_against_guess
            @round += 1
            self.check_win
        end
    end

    def ask_for_guess
        puts "Round #{@round}: What is your guess ? "
        @guess = gets.chomp.split()
        @guess.each_with_index {|item, index| @guess[index] = item.to_i}
    end

    def check_win
        if @exact_match == 4 
            @win = true
            puts "Congratulation ! You have found the code"
        elsif @round == 12
            puts "You lost :( The code was #{@code}"
        end
    end
        
end


game = Game.new
game.player_choice
game.new_game
game.advance_rounds