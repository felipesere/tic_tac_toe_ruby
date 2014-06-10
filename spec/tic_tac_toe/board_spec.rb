require 'spec_helper'

describe Board do
  
  let(:board) { Board.empty }

  context "#empty" do
    it "results in an empty board" do
      expect(board.empty?).to be true
    end

    it "all moves are still possible (9)" do
      expect(board.possible_moves.size).to eq 9
    end
  end

  context "#mark" do
    let(:marked_board) { board.mark :x, row: 0, column: 0  }
    
    it "the original board is not affected" do
      expect(board.empty?).to be true
    end

    it "is no longer empty if a place is marked" do
      expect(marked_board.empty?).to be false
    end

    it "knows which positions are marked after marking them" do
      expect(marked_board.marked?(0,0)).to be true
    end
  end
end
