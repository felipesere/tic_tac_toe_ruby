require 'tic_tac_toe/players/player_factory'

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

  it "create the proper permutations" do
    expect(factory.player_combinations).to include([:human,:human], [:human,:computer],[:computer, :human],[:computer,:computer])
  end
end
