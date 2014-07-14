require 'spec_helper'
require 'tic_tac_toe/ui/io'

describe TicTacToe::UI::IO do

  it "prints to individual lines" do
    output = StringIO.new
    TicTacToe::UI::IO.new(output: output).write "sentinel"
    expect(output.string).to eq "sentinel\n"
  end

  it "trims control characters when reading" do
    input = StringIO.new("sentinel\n")
    io = TicTacToe::UI::IO.new(input: input)
    expect(io.read).to eq "sentinel"
  end
end
