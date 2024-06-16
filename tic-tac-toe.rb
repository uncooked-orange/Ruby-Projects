class Game
    attr_reader :p1,:p2,:gameboard
    
    def initialize(p1_name,p2_name)
        @turn = -1
        @p1 = p1_name
        @p2 = p2_name
        @gameboard = []
        for i in 1..9
            @gameboard[i-1] = "#{i}"
        end
    end

    private
    def playerturn
        (@turn % 2) == 0 ? @p2 : @p1
    end
    def display
        for i in 0...9
            print "#{gameboard[i]}      "
            if((i+1) % 3 == 0)
                puts ""
                puts ""
            end
        end
    end
    def get_input
        player_input = gets.chomp
        if (player_input >= "1" && player_input <= "9")
            if @gameboard[player_input.to_i() - 1] == (player_input)
                @gameboard[player_input.to_i() - 1] = (playerturn == @p1 ? 'X' : "O")
            else
                puts "invalid position"
                get_input()
            end
        else
            puts "invalid input"
            get_input()
        end
    end
    def wincon
        rows = [@gameboard.slice(0,3),@gameboard.slice(3,3),@gameboard.slice(6,3)]
        diags = [[],[]]
        colums = [[],[],[]]
        o_array = Array.new(3,"O")
        x_array = Array.new(3,"X")
        for i in 0...3
            diags[0] << rows[i][i]
            diags[1] << rows[i][2-i]
            colums[0] << rows[i][0]
            colums[1] << rows[i][1]
            colums[2] << rows[i][2]
        end
        for i in 0...3
            if rows[i] == x_array || diags[i] == x_array || colums[i] == x_array
                return true 
            elsif rows[i] == o_array || diags[i] == o_array || colums[i] == o_array
                return true 
            end
        end
        return false
    end
    def checkresult
        if @turn >= 4
            if wincon
                puts "#{playerturn == @p2 ? @p1 : p2} has WON!"
                puts ""
                return true
            elsif @turn == 8
                puts "it's a DRAW!"
                return true
            end
        end
        
        return false
    end

    public
    def play
        loop do
            if checkresult
                display
                return 0
            else
                puts "its #{playerturn}'s turn :-"
                display
                get_input
            end
            @turn +=1
        end
    end
end

print ("player number 1: ")
player1 = gets().chomp
print ("player number 2: ")
player2 = gets().chomp
g1 = Game.new(player1,player2)
g1.play