require 'tic_tac_toe/players/random_player'

describe TicTacToe::Players::RandomPlayer do
  let(:board) { TicTacToe::Board.create_empty }
  let(:player) { TicTacToe::Players::RandomPlayer.new(:x, {}) }
  it "returns a valid move" do
    new_board = player.perform_move(board)
    expect(new_board.possible_moves.size).to be < board.possible_moves.size
  end
  it "is always ready" do
    expect(player.ready?).to be true
  end
end
