require 'spec_helper'

describe Player do

  let(:player) { Player.new(:x) }
  let(:board) { Board.create_empty }
  let(:board_size) { board.possible_moves.size }

  context '#perform_move' do
    it "should perform a single move" do
      new_board = player.perform_move(board)
      expect(new_board.possible_moves.size).to eq (board_size - 1)
    end

    let(:direct_win_board) do
      Board.create [[:x, :x, nil],[nil, nil, nil],[nil, nil, nil]]
    end

    it "should pic the eassiest direct win" do
      result = player.perform_move direct_win_board
      expect(result.has_winner? ).to be true
    end
  end
end
