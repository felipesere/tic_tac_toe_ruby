require 'spec_helper'
require 'tic_tac_toe/ui/cli_interface'
require 'tic_tac_toe/board'

describe TicTacToe::UI::CliInterface do
  let(:board) { TicTacToe::Board.create_empty }
  let(:fake_output) { StringIO.new }
  let(:display) { TicTacToe::UI::CliInterface.new(output: fake_output) }
  
  before(:each) do
    fake_output.rewind
  end

  context '#render' do
    it 'returns a blank ASCII board when the board is empty' do
      display.render(board)
      expect(fake_output.string.chomp).to eq("[1][2][3]\n[4][5][6]\n[7][8][9]")
    end

    it 'shows the player name when marked' do
      marked_board = board.perform_move(:x, board.possible_moves.first)
      display.render(marked_board)
      expect(fake_output.string.chomp).to eq("[x][2][3]\n[4][5][6]\n[7][8][9]")
    end

    context '#color_cell' do
      let(:color_display) { TicTacToe::UI::CliInterface.new(colors: true) }
      it 'draws the :x red' do
        RED="\e[0;31;49m"
        expect(color_display.color_cell(:x)).to include RED
      end

      it 'draws the :o blue' do
        BLUE="\e[0;34;49m"
        expect(color_display.color_cell(:o)).to include BLUE
      end
    end
  end

  context 'messages' do
    it 'displays a proper error message' do
      display.input_error('foo')
      expect(fake_output.string).to include('foo')
    end

    it 'disaplays the proper player name' do
      display.message_winner(:x)
      expect(fake_output.string).to include('x')
    end

    it 'displays the draw message properly' do
      display.message_draw
      expect(fake_output.string).not_to be_empty
    end
  end

  context '#read_user_input' do
    it 'properly strips line breaks from input' do
      fake_input = StringIO.new("foo\n\r")
      display = TicTacToe::UI::CliInterface.new(input: fake_input)
      expect(display.read_user_input).to eq 'foo'
    end
  end
end
