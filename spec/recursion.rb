require 'spec_helper'

describe "recursion" do
  let(:player) { Player.new(:x) }
  let(:opponent) { Player.new(:o) }

  it "should not die when going first" do
    board = Board.create_empty
    new_board = player.perform_move(board)
    new_board = opponent.perform_move(new_board)
    new_board = player.perform_move(new_board)
    new_board = opponent.perform_move(new_board)
    
    expect(new_board.possible_moves.size).to eq 5
  end

  xcontext "should generate the same key" do

    it "for two empty boards " do
      a = Board.create_empty
      b = Board.create_empty
      expect(a.generate_key).to eq b.generate_key 
    end

    it "for two boards with moves applied" do
      a = Board.create_empty
      b = Board.create_empty
      first_move =  Move.new(row: 0, column: 0)
      second_move = Move.new(row:2, column: 1)
      
      new_a = a.perform_move(:x, first_move).perform_move(:o, second_move)
      new_b = b.perform_move(:x, first_move).perform_move(:o, second_move)

      expect(new_a.generate_key).to eq new_b.generate_key
      expect(a.generate_key).not_to eq new_a.generate_key
    end
  end
end
