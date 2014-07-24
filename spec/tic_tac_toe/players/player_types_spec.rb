require 'tic_tac_toe/players/player_types'

describe TicTacToe::Players::PlayerTypes do
  it "create the proper permutations" do
    expect(TicTacToe::Players::PlayerTypes.player_combinations).to include([:human,:human], 
                                                   [:human,:computer],
                                                   [:computer, :human],
                                                   [:computer,:computer])
  end
end
