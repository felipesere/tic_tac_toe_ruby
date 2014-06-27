module TicTacToe
  class HumanPlayer
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def perform_move(board)
      puts "Which move?"
      index = $stdin.gets.chomp
      move = board.possible_moves[index.to_i]
      board.perform_move(@name, move)
    end
  end
end
