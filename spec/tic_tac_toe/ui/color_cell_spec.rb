require 'tic_tac_toe/ui/color_cell'

describe TicTacToe::UI::ColorCell do
  RED="\e[0;31;49m"
  BLUE="\e[0;34;49m"
  { :x => RED,
    :o => BLUE
  }.each do |cell, color|
    it "color the :#{cell} properly" do
      color_cell = TicTacToe::UI::ColorCell.new(cell)
      expect(color_cell.paint).to include color
    end
  end

  it "does not color numbers" do
    color_cell = TicTacToe::UI::ColorCell.new(1)
    expect(color_cell.paint).to eq "[1]"
  end
end
