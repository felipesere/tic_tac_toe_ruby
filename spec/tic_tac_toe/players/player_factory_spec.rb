require 'tic_tac_toe/players/player_factory'
require 'tic_tac_toe/players/human_player'
require 'tic_tac_toe/players/fast_ai_player'
require 'tic_tac_toe/players/random_player'

describe TicTacToe::Players::PlayerFactory do

  let(:factory) {TicTacToe::Players::PlayerFactory.new(io: false) }

  {
    :human    => TicTacToe::Players::HumanPlayer,
    :computer => TicTacToe::Players::FastAiPlayer,
    :random   => TicTacToe::Players::RandomPlayer
  }.each do |type, klass|
    it "creates a #{type} player named x" do
      result = factory.player(type: type, name: :x)
      expect(result).to be_a(klass)
      expect(result.name).to eq :x
    end
  end
end
