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

  it "displays a proper error message" do
    fake_out = StringIO.new
    display = CliInterface.new(nil, fake_out)
    display.input_error("foo")
    expect(fake_out.string).to include('foo')
  end
end
