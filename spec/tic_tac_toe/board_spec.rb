require 'spec_helper'

describe Board do
  
  let(:board) { Board.new }

  context "#new" do
    it "results in an empty board" do
      expect(board.empty?).to be true
    end
  end

  context "#mark" do
    
    let(:marked_board) { board.mark :x, row: 0, column: 0  }
    
    it "is no longer empty if a place is marked" do
      expect(marked_board.empty?).to be false
    end
  end
end
