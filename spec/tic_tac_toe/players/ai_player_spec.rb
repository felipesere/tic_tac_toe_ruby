require 'spec_helper'
require 'tic_tac_toe/players/ai_player'

describe TicTacToe::Players::AiPlayer do

  let(:player) { TicTacToe::Players::AiPlayer.create(:x) }
  let(:board) { TicTacToe::Board.create_empty }
  let(:board_size) { board.possible_moves.size }

  context '#perform_move' do
    it 'should perform a single move' do
      new_board = player.perform_move(board)
      expect(new_board.possible_moves.size).to eq (board_size - 1)
    end

    let(:direct_win_board) do
      TicTacToe::Board.new [[:x, :x, nil], [nil, nil, nil], [nil, nil, nil]]
    end

    it 'should pic the eassiest direct win' do
      result = player.perform_move(direct_win_board)
      expect(result.has_winner? ).to be true
    end

    let(:direct_defense_board) do
      TicTacToe::Board.new [[nil, nil, nil], [:o, :o, nil], [nil, nil, nil]]
    end

    it 'should block if necessary' do
      result = player.perform_move(direct_defense_board)
      expect(result.marked?(1, 2)).to be true
    end
  end

  context '#value_of_move' do
    it 'scores positive if it wins' do
      board = TicTacToe::Board.new [[:x, :x,  nil], [nil, nil, nil], [nil, nil, nil]]
      move = 3
      expect(player.value_of_move(board, move)).to be > 0
    end

    it 'scores negative if x loses' do
      board = TicTacToe::Board.new [[:o, :o, nil], [nil, nil, nil], [nil, nil, nil]]
      move = 3
      expect(player.value_of_move(board, move)).to be < 0
    end

    it 'scores 0 if there is a draw' do
      board = TicTacToe::Board.new [[:o, :o, :x], [:x, :x, :o], [:o, :x, nil]]
      move = 9
      expect(player.value_of_move(board, move)).to eq 0
    end

    it 'scores negative if it is one move away from a loss' do
      board = TicTacToe::Board.new [[:o, :o, nil], 
                                       [:o, :x, :x],
                                       [nil, :x, :o]]
      move = 3
      expect(player.value_of_move(board, move)).to be < 0
    end
  end
end
