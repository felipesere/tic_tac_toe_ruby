require 'spec_helper'

describe CliDisplay do

  let(:board) { Board.create_empty }
  let(:display) { CliDisplay.new }
  
  context "#render" do
    it "returns a blank ASCII board when the board is empty" do
      result = display.render(board)
      puts result
      expect(result).to eq("[1][2][3]\n[4][5][6]\n[7][8][9]\n")
    end

    it "shows the player name when marked" do
      marked_board = board.perform_move(:x, board.possible_moves.first)
      result = display.render(marked_board)
      puts result
      expect(result).to eq("[x][2][3]\n[4][5][6]\n[7][8][9]\n")
    end
  end
end
