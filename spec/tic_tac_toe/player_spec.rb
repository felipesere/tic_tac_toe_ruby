require 'spec_helper'

describe Player do

  let(:player) { Player.create(:x) }
  let(:board) { Board.create_empty }
  let(:board_size) { board.possible_moves.size }

  context '#perform_move' do
    it 'should perform a single move' do
      new_board = player.perform_move(board)
      expect(new_board.possible_moves.size).to eq (board_size - 1)
    end

    let(:direct_win_board) do
      Board.create [[:x, :x, nil], [nil, nil, nil], [nil, nil, nil]]
    end

    it 'should pic the eassiest direct win' do
      result = player.perform_move(direct_win_board)
      expect(result.has_winner? ).to be true
    end

    let(:direct_defense_board) do
      Board.create [[nil, nil, nil], [:o, :o, nil], [nil, nil, nil]]
    end

    it 'should block if necessary' do
      result = player.perform_move(direct_defense_board)
      expect(result.marked?(1, 2)).to be true
    end

    context 'set up fork where possible' do
      it 'marks the middle row on the left to fork' do
        board = Board.create [[:x, :o, nil ], [nil, :x, nil], [nil, nil,:o]]
        result = player.perform_move(board)
        expect(result.marked?(1, 0)).to be true
      end
    end
  end

  context '#value_of_move' do
    it 'scores 10 if it wins' do
      board = Board.create [[:x, :x,  nil], [nil, nil, nil], [nil, nil, nil]]
      move = Move.new(row: 0, column: 2)
      expect(player.value_of_move(board, move)).to eq 10
    end

    it 'scores -10 if x loses' do
      board = Board.create [[:o, :o, nil], [nil, nil, nil], [nil, nil, nil]]
      move = Move.new(row: 0, column: 2)
      expect(player.value_of_move(board, move)).to eq -10
    end

    it 'scores 0 if there is a draw' do
      board = Board.create [[:o, :o, :x], [:x, :x, :o], [:o, :x, nil]]
      move = Move.new(row: 2, column: 2)
      expect(player.value_of_move(board, move)).to eq 0
    end

    it 'scores -10 if it is one move away from a loss' do
      board = Board.create [[:o, :o, nil], [:o, :x, :x], [nil, :x, :o]]
      move = Move.new(row: 0, column: 2)
      expect(player.value_of_move(board, move)).to eq -10
    end
  end
end
