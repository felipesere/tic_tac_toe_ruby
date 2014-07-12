require 'tic_tac_toe/players/player_factory'

describe TicTacToe::Players::PlayerFactory do

  let(:factory) {TicTacToe::Players::PlayerFactory.new}

  {
    :human    => TicTacToe::Players::HumanPlayer,
    :computer => TicTacToe::Players::FastAiPlayer
  }.each do |type, klass|
    it "creates a #{type} player named x" do
      result = factory.player(type: type, name: :x)
      expect(result).to be_a(klass)
      expect(result.name).to eq :x
    end
  end

  it "announces the types it supportes" do
    expect(factory.types).to eq [:human, :computer]
  end
end
