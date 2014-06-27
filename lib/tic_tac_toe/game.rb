module TicTacToe
  class Game
   
    attr_reader :board

    def initialize(player, opponent)
      @board = Board.create_empty
      @player = player
      @opponent = opponent
      @current_player = @player
      @display = CliDisplay.new
    end

    def start
      until @board.is_finished?  do
        play(other_player)
        draw
      end
    end

    def play(player)
     @board = player.perform_move(@board)
    end

    def draw
      @display.render(@board)
    end

    def other_player
      @current_player == @player ? @opponent : @player
    end

    def is_finished?
      @board.is_finished?
    end

    def winner
      @current_player.name
    end
  end
end
