module TicTacToe
  class FakeGame

    def tick
      move = @current_board.possible_moves.first
      @current_board = @current_board.perform_move(@player, move)
    end

    def winning_board_for(player)
      @current_board = TicTacToe::Board.new([[player, player, player], 
                                             [player, player, player], 
                                             [player, player, player]]) 
    end

    def second_last_board(player)
      @current_board = TicTacToe::Board.new([[nil, :o, :x],[:x, :o, :x],[:o, :x, :o]])
      @player = player
    end

    def board_with_draw
      @current_board = TicTacToe::Board.new([[:x, :o, :x],[:x, :o, :x],[:o, :x, :o]])
    end

    def current_board
      @current_board
    end

    def is_finished?
      @current_board.is_finished?
    end
  end
end
