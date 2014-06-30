require 'spec_helper'

describe HumanPlayer do
  let(:board) { Board.create_empty }
  let(:human_input) { FakeInterface.new }
  let(:player) { HumanPlayer.new(:x, human_input) }

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

  class FakeInterface

    def chooses(*value)
      @value = value
    end

    def read_user_input
      if @value.empty?
        raise "Read more than expected"
      end
      "#{@value.shift}" 
    end

    def input_error(value)
    end
  end
end
