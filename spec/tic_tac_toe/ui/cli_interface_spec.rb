require 'spec_helper'
require 'tic_tac_toe/ui/cli_interface'
require 'tic_tac_toe/ui/fake_io'
require 'tic_tac_toe/fake_game'
require 'tic_tac_toe/board'

describe TicTacToe::UI::CliInterface do
  let(:board) { TicTacToe::Board.create_empty }
  let(:fake_io) { TicTacToe::UI::FakeIO.new }
  let(:interface) { TicTacToe::UI::CliInterface.new(io: fake_io) }
  
  before(:each) do
    fake_io.rewind
  end

  context '#render' do
    it 'returns a blank ASCII board when the board is empty' do
      interface.render(board)
      expect(fake_io.string.chomp).to eq("[1][2][3]\n[4][5][6]\n[7][8][9]")
    end

    it 'shows the player name when marked' do
      marked_board = board.perform_move(:x, board.possible_moves.first)
      interface.render(marked_board)
      expect(fake_io.string.chomp).to eq("[x][2][3]\n[4][5][6]\n[7][8][9]")
    end
  end

  context 'messages' do
    it 'displays a proper error message' do
      interface.input_error('foo')
      expect(fake_io.string).to include('foo')
    end

    it 'disaplays the proper player name' do
      interface.message_winner(:x)
      expect(fake_io.string).to include('x')
    end

    it 'displays the draw message properly' do
      interface.message_draw
      expect(fake_io.string).not_to be_empty
    end
  end

  context '#get_chosen_players' do
    before(:each) { fake_io.rewind }
    it "shows a single combination of players" do
      interface = TicTacToe::UI::CliInterface.new(io: fake_io, player_combinations: [[:a, :b]])
      fake_io.chooses(0)

      interface.get_chosen_players
      expect(fake_io.string).to match /a vs. b/
    end
    
    context "it denies invalid input" do
      it "out of range" do
        interface = TicTacToe::UI::CliInterface.new(io: fake_io, player_combinations: [[:a, :b]])
        fake_io.chooses(99,0)
        expect(interface.get_chosen_players).to include :a, :b
      end
      
      it "strings" do
        interface = TicTacToe::UI::CliInterface.new(io: fake_io, player_combinations: [[:a, :b],[:c, :d],[:e, :f]])
        fake_io.chooses("abc" ,2)

        expect(interface.get_chosen_players).to include :e, :f
      end
    end
  end

  # These tests need some heavy love...
  context '#play_on' do
    let(:game) { TicTacToe::FakeGame.new }
    it "notifies win " do
      game.winning_board_for(:x)
      interface.play_on(game)
      expect(fake_io.string).to include "The winner is x"
    end

    it "notifies for a draw" do
      game.board_with_draw
      interface.play_on(game)
      expect(fake_io.string).to include "There was a draw"
    end

    it "runs for one more round" do
      game.second_last_board(:x)
      interface.play_on(game)
      expect(fake_io.string).to include "There was a draw" 
    end
  end
end
