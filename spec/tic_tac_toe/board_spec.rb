require 'spec_helper'

describe Board do
  
  let(:board) { Board.empty }

  context "#empty" do
    it "all moves are still possible (9)" do
      expect(board.possible_moves.size).to eq 9
    end
  end

  context "#mark" do
    let(:marked_board) { board.mark :x, row: 0, column: 0  }
    
    it "to return a new/different board" do
      expect(marked_board).not_to be board
    end

    it "knows which positions are marked after marking them" do
      expect(marked_board.marked?(0,0)).to be true
    end

    context "#possible_moves" do
      it "is reduced after marking a place" do
        before = board.possible_moves.size
        expect(marked_board.possible_moves.size).to be(before-1)
      end
    end
  end
end
