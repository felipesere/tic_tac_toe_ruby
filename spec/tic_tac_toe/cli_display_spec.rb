require 'spec_helper'

describe CliInterface do

  let(:board) { Board.create_empty }
  let(:display) { CliInterface.new }
  
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

  context "#get_move" do
    it "markes the right place without offset" do
      move = display.get_move(board, "1")
      marked_board = board.perform_move(:x, move)
      expect(marked_board.marked?(0,0)).to be true
    end
    
    it "markes the right place with offset" do
      marked_board = board.perform_move(:x, board.possible_moves[5])
      move = display.get_move(marked_board, "7")
      marked_board = board.perform_move(:x, move)
      expect(marked_board.marked?(2,0)).to be true
    end
  end
end
