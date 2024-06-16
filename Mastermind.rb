module Resources
    def colors 
        @colors = ['red' ,'green' ,'blue' ,'yellow']
    end
    def generate_code(num_of_words)
        code = Array.new(num_of_words)
        for i in 0...num_of_words
            code[i] = self.colors[rand(4)]
        end
        code
    end
end

class Game
    include Resources
    attr_accessor :comp_code, :usr_code, :guesses, :num_of_words
    def initialize(num_words = 4)
        @num_of_words = num_words
        @comp_code = generate_code(num_words)
        @guesses = 0
        @usr_code = Array.new(@num_of_words)
    end

    def usr_guess
        print "enter your guess: "
        user_input_guess = gets.split()
        user_input_guess.each do |word|
            unless colors.include?(word) && user_input_guess.length == @num_of_words
                puts "invalid input"
                usr_guess
                return 0
            end
        end
        @guesses+=1
        @usr_code = user_input_guess
        return @usr_code
    end

    def correct_guesses
        num_of_correct_guesses = 0
        correctly_guessed_colors = Array.new(@num_of_words+1,"____")
        if @usr_code == @comp_code #win condition
            correctly_guessed_colors = "correct"
            return correctly_guessed_colors
        end
        comp_remainder = @comp_code.clone
        usr_remainder = @usr_code.clone
        for i in 0...@num_of_words
            if comp_remainder[i] == @usr_code[i]
                correctly_guessed_colors[i] = @usr_code[i]
                comp_remainder[comp_remainder.index(@usr_code[i])] = ""
            end
            if usr_remainder.include?(comp_code[i])
                num_of_correct_guesses +=1
                usr_remainder[usr_remainder.index(comp_code[i])] = ""
            end
        end
        correctly_guessed_colors[-1] = num_of_correct_guesses
        return correctly_guessed_colors
    end
    
    def display
        if correct_guesses == "correct"
            puts "YOU WON!"
            puts "correct guess: " + @comp_code.to_s
            puts "you got it in " + @guesses.to_s + " guesses!"
        else
            puts "your code:                " + @usr_code.to_s
            puts "correctly guessed colors: " + correct_guesses.take(@num_of_words).to_s
            puts "Number of correctly guessed colors: " + correct_guesses[-1].to_s
            puts "Number of guesses: " + @guesses.to_s
        end
    end

    def play
        puts "Lets play Mastermind!"
        until correct_guesses == "correct" || @guesses == @num_of_words+1
            usr_guess
            puts ""
            self.display
            puts ""
        end
        if @guesses > @num_of_words
            puts "you ran out of guesses, you lost!"
        end
    end
end

g1 = Game.new
g1.play