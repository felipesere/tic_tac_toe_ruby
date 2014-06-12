require 'spec_helper'

describe Player do

  let(:player) { Player.new(:x) }
  let(:board) { Board.create_empty }
  let(:board_size) { board.possible_moves.size }

  context '#perform_move' do
    it 'should perform a single move' do
      new_board = player.perform_move(board)
      expect(new_board.possible_moves.size).to eq (board_size - 1)
    end

    let(:direct_win_board) do
      Board.create [[:x, :x, nil],[nil, nil, nil],[nil, nil, nil]]
    end

    it 'should pic the eassiest direct win' do
      result = player.perform_move direct_win_board
      expect(result.has_winner? ).to be true
    end

    let(:direct_defense_board) do
      Board.create [[nil, nil, nil],[:y, :y, nil],[nil, nil, nil]]
    end

    it 'should block if necessary' do
      result = player.perform_move (direct_defense_board)
      expect(result.marked?(1,2)).to be true
    end

    it 'should switch correctly' do
      expect(player.switch_player(:x)).to eq :y
      expect(player.switch_player(:y)).to eq :x
    end
  end
end
