require 'spec_helper'
require 'tic_tac_toe/players/fast_ai_player'
require 'tic_tac_toe/board'

describe TicTacToe::Players::FastAiPlayer do

  let(:player) { TicTacToe::Players::FastAiPlayer.new(:x) }
  let(:board) { TicTacToe::Board.create_empty }
  let(:board_size) { board.possible_moves.size }

  context '#perform_move' do
    it 'should perform a single move' do
      new_board = player.perform_move(board)
      expect(new_board.possible_moves.size).to eq (board_size - 1)
    end

    let(:direct_win_board) do
      TicTacToe::Board.create [[nil, nil, nil],[:x, :x, nil],[nil, nil, nil]]
    end

    it 'should pic the easiest direct win' do
      result = player.perform_move(direct_win_board)
        expect(result.has_winner? ).to be true 
      end

      let(:direct_defense_board) do
      TicTacToe::Board.create [[nil, nil, nil], [:o, :o, nil], [nil, nil, nil]]
    end

    it 'should block if necessary' do
      result = player.perform_move(direct_defense_board)
      expect(result.marked?(1, 2)).to be true
    end

    context 'set up fork where possible' do
      it 'marks the middle row on the left to fork' do
        board = TicTacToe::Board.create [[:x, :o, nil ], [nil, :x, nil], [nil, nil,:o]]
        result = player.select_move(board)
        moves = [3, 6]
        expect(moves).to include result
      end
    end
   
    it "defends against a corner" do
      board = TicTacToe::Board.create [[:o, nil, nil],[nil, nil, nil],[nil,nil,nil]]
      result = player.select_move(board)
      expect(result).to eq 4 
    end
  end
end
