require 'spec_helper'

describe CliInterface do

  let(:board) { Board.create_empty }

  context "#render" do
    it "returns a blank ASCII board when the board is empty" do
      fake_out = StringIO.new
      display = CliInterface.new(StringIO.new, fake_out)

      display.render(board)
      expect(fake_out.string).to eq("[1][2][3]\n[4][5][6]\n[7][8][9]\n")
    end

    it "shows the player name when marked" do
      marked_board = board.perform_move(:x, board.possible_moves.first)
      fake_out = StringIO.new
      display = CliInterface.new(StringIO.new, fake_out)

      display.render(marked_board)
      expect(fake_out.string).to eq("[x][2][3]\n[4][5][6]\n[7][8][9]\n")
    end
  end

  context "#get_move" do
    it "markes the right place without offset" do
      input = StringIO.new("1")
      display = CliInterface.new(input, StringIO.new)

      move = display.get_move(board)
      marked_board = board.perform_move(:x, move)
      expect(marked_board.marked?(0,0)).to be true
    end

    it "markes the right place with offset" do
      marked_board = board.perform_move(:x, board.possible_moves[5])
      input = StringIO.new("7")
      display = CliInterface.new(input,StringIO.new)

      move = display.get_move(marked_board)
      marked_board = board.perform_move(:x, move)
      expect(marked_board.marked?(2,0)).to be true
    end

    context "invalid move" do
      it "should only allow numbers" do
        input = StringIO.new("xyz\n4")
        display = CliInterface.new(input, StringIO.new)
        expect(display.get_move(Board.create_empty).row).to eq 1
      end

      it "should not allow to select an unavailable move" do
        marked_board = board.perform_move(:x, board.possible_moves.first)
        input = StringIO.new("1\n2")
        display = CliInterface.new(input,StringIO.new)

        move = display.get_move(marked_board)
        expect(move.column).to eq 1
      end
    end
  end
end
