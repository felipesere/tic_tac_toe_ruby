require 'spec_helper'

describe CliInterface do
  let(:board) { Board.create_empty }
  let(:fake_out) { StringIO.new }
  let(:display) { CliInterface.new(nil, fake_out) }
  
  before(:each) do
    fake_out.rewind
  end

  context '#render' do
    it 'returns a blank ASCII board when the board is empty' do
      display.render(board)
      expect(fake_out.string.chomp).to eq("[1][2][3]\n[4][5][6]\n[7][8][9]")
    end

    it 'shows the player name when marked' do
      marked_board = board.perform_move(:x, board.possible_moves.first)
      display.render(marked_board)
      expect(fake_out.string.chomp).to eq("[x][2][3]\n[4][5][6]\n[7][8][9]")
    end

    context '#color_cell' do
      let(:color_display) { CliInterface.new(nil, nil, true, false) }
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
      expect(fake_out.string).to include('foo')
    end

    it 'disaplays the proper player name' do
      display.message_winner(:x)
      expect(fake_out.string).to include('x')
    end

    it 'displays the draw message properly' do
      display.message_draw
      expect(fake_out.string).not_to be_empty
    end
  end

  context '#read_user_input' do
    it 'properly strips line breaks from input' do
      input = StringIO.new("foo\n\r")
      display = CliInterface.new(input)
      expect(display.read_user_input).to eq 'foo'
    end
  end
end
