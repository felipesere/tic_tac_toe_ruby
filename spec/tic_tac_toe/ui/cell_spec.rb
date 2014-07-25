require 'tic_tac_toe/ui/cell'

describe TicTacToe::UI::Cell do
  { :x => "[x]",
    :o => "[o]",
    1 => "[1]"
  }.each do |cell, view|
    it "creates the proper representation for :#{cell}" do
      cell = TicTacToe::UI::Cell.new(cell)
      expect(cell.paint).to eq view
    end
  end
end
