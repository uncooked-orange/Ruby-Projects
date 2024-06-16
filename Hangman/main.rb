require 'json'
module Resoures 
    def wordspicker
        words = File.open('words.txt', 'r').readlines
        word = words[rand(0..words.length)]
        if word.strip.length >=5
            return word
        else
            wordspicker
        end
    end
end

class Game
    include Resoures
    attr_accessor :player_guess , :comp_pick ,:guesses ,:current_word_revealed, :letters_guessed
    def initialize
        @comp_pick = wordspicker.strip
        @guesses = 0
        @current_word_revealed = Array.new(comp_pick.length,"_")
        @letters_guessed = Array.new
    end

    def save_game
        save = JSON.dump({
            :comp_pick => @comp_pick,
            :letters_guessed => @letters_guessed,
            :guesses => @guesses,
            :current_word_revealed => @current_word_revealed
            })
        File.open('saves.txt', 'a') do |f|
            f.puts(save)
        end
        puts "Your game has been saved"
    end

    def load_game
        if File.zero?('saves.txt')
            puts "You have no saved games"
            return false
        end
        game = JSON.parse(File.open('saves.txt', 'r').readlines[-1])
        @guesses = game['guesses']
        @current_word_revealed = game['current_word_revealed']
        @letters_guessed = game['letters_guessed']
        @comp_pick = game['comp_pick']
        puts "Your game has been loaded"
        loaded_file = Array.new(File.open('saves.txt', 'r').readlines)
        loaded_file.pop()
        File.open('saves.txt', 'w') do |f|
            f.puts(loaded_file)
        end
        return true
    end

    def player_input
        puts "Enter a letter, save the game(save) or quit(quit):" 
        input = gets.chomp
        if input == 'save'
            self.save_game
        elsif input == 'quit'
            @player_guess = 'quit'
        elsif input.length > 1 ||input == "" || !(input >= 'a' && input <= 'z')
            puts "invalid input, please enter 1 character or save the game"
            player_input
        elsif @letters_guessed.include?(input)
            puts "invalid input, you have already guessed this letter"
            player_input
        else
            @player_guess = input
            @guesses+=1
            unless @letters_guessed.include?(input)
                @letters_guessed << input
            end
        end
    end

    def matching_guess
        for i in 0...comp_pick.length
            if @comp_pick[i] == @player_guess
                @current_word_revealed[i] = @player_guess
            end
        end
    end

    def display
        puts "\n"
        puts "the  current word revealed: " + @current_word_revealed.to_s
        puts "the letters that you guessed: " + @letters_guessed.to_s
        puts "guesses left : " + (@comp_pick.length + 4 - @guesses).to_s
        puts "\n"
    end
    def game_play
        puts "the  current word revealed: " + @current_word_revealed.to_s
        puts "the letters that you guessed: " + @letters_guessed.to_s
            while @current_word_revealed != @comp_pick.split("") and @guesses < @comp_pick.length+4
                self.player_input
                self.matching_guess
                self.display
                if @player_guess == 'quit'
                    puts "Goodbye!"
                    return nil
                end
            end
            if @guesses == @comp_pick.length+4 and @current_word != @comp_pick.split("")
                puts "you lost!\n"
                puts "the word was " + @comp_pick
            else
                puts "you won!"
            end
    end
    def play
        puts "let's play Hangman!"
        puts "Would you like to start a new game (1) or load the last saved game (2)? : "
        game_input = gets.chomp.strip
        if game_input == '1'
            self.game_play  
        elsif game_input == '2'
            if self.load_game
                self.game_play
            end
        else
            puts "invalid input"
            self.play
        end

    end
end

g1 = Game.new
g1.play