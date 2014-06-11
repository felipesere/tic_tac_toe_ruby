require 'spec_helper'

describe Board do

  let(:board) { Board.create_empty }

  context '#create_empty' do
    it 'all moves are still possible (9)' do
      expect(board.possible_moves.size).to eq 9
    end

    xit 'has no winner' do
      expect(board.winner?).to be false
    end
  end

  context '#perform_move' do
    let(:move) { board.possible_moves.first }
    let(:marked_board) { board.perform_move :x, move }

    it 'returns a new/different board' do
      expect(marked_board).not_to be board
    end

    context '#possible_moves' do
      let(:moves_before) { board.possible_moves.size }

      it 'reduces the number of possible moves' do
        expect(marked_board.possible_moves.size).to be(moves_before - 1)
      end
    end
  end
end
