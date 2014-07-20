require 'spec_helper'
require 'tic_tac_toe/players/fast_ai_player'
require 'tic_tac_toe/board'

describe TicTacToe::Players::FastAiPlayer do

  let(:player)     { TicTacToe::Players::FastAiPlayer.new(:x, {}) }
  let(:board)      { TicTacToe::Board.create_empty }
  let(:board_size) { board.possible_moves.size }

  it "is always ready to make a move" do
    expect(player.ready?).to be true
  end
  context '#perform_move' do
    it 'should perform a single move' do
      new_board = player.perform_move(board)
      expect(new_board.possible_moves.size).to be < board_size 
    end

    let(:direct_win_board) do
          end

    it 'should pic the easiest direct win' do
      board = TicTacToe::Board.new [[nil , nil , nil]  ,
                                       [:x  , :x  , nil]  ,
                                       [nil , nil , nil]]

      result = player.perform_move(board)
      expect(result.has_winner? ).to be true 
    end

    it 'should block if necessary' do
      board = TicTacToe::Board.new [[nil , nil , nil]  ,
                                       [:o  , :o  , nil]  ,
                                       [nil , nil , nil]]
      result = player.perform_move(board)
      expect(result.marked?(1, 2)).to be true
    end

    context 'set up fork where possible' do
      it 'marks the middle row on the left to fork' do
        board = TicTacToe::Board.new [[:x  , :o  , nil ] ,
                                         [nil , :x  , nil]  ,
                                         [nil , nil , :o]]
        result = player.select_move(board)
        moves = [4, 7]
        expect(moves).to include result
      end
    end

    it "defends against a corner" do
      board = TicTacToe::Board.new [[:o  , nil , nil]  ,
                                       [nil , nil , nil]  ,
                                       [nil , nil , nil]]
      result = player.select_move(board)
      expect(result).to eq 5 
    end
  end
end
