require 'spec_helper'
require 'tic_tac_toe/players/human_player'
require 'tic_tac_toe/ui/fake_io'

describe TicTacToe::Players::HumanPlayer do
  let(:board) { TicTacToe::Board.create_empty }
  let(:human_input) { TicTacToe::UI::FakeIO.new }
  let(:player) { TicTacToe::Players::HumanPlayer.new(:x, {io: human_input}) }

  context "readiness to make a move" do
    it "is ready when @io is ready" do
      human_input.ready!
      expect(player.ready?).to eq true
    end
    it "is not ready when @io is not ready" do
      human_input.not_ready!
      expect(player.ready?).to eq false
    end
  end

  it "markes the right place without offset" do
    human_input.chooses(1)
    new_board = player.perform_move(board)
    expect(new_board.marked?(0,0)).to be true
  end

  it "markes the right place with offset" do
    marked_board = board.perform_move(:x, board.possible_moves[5])
    human_input.chooses(7)
    
    new_board = player.perform_move(board)
    expect(new_board.marked?(2,0)).to be true
  end

  context "invalid move" do
    it "should only allow numbers" do
      human_input.chooses("fooooo", 7)
      new_board = player.perform_move(board)
      expect(new_board.marked?(2,0)).to be true
    end

    it "should not allow to select an unavailable move" do
      marked_board = board.perform_move(:x, board.possible_moves.first)
      human_input.chooses(1,7)
      new_board = player.perform_move(marked_board)
      expect(new_board.marked?(2,0)).to be true
    end
  end
end
