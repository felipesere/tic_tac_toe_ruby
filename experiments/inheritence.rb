$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

require 'tic_tac_toe/players/player_factory'


class Cell < Shoes::Widget
  def initialize(cell, index)

  end
end

class Mine < Shoes
  url '/',     :index
  url '/game', :game
  url '/over', :over

  
  def convert(player_combinations)
    result = {}
    player_combinations.each do |combo|
      line = "#{combo[0]} vs. #{combo[1]}"
      result[line] = combo
    end
    result
  end

  def index
    @factory = TicTacToe::Players::PlayerFactory.new(io: nil)
    stack :margin =>  10 do
      para "Choose the players"
      output = convert(@factory.player_combinations)
      input = list_box :items => output.keys
      button "Start" do
        @@gg = output[input.text]
        visit '/game'
      end
    end
  end

  def game
    @factory = TicTacToe::Players::PlayerFactory.new(io: nil)
    real_players = @factory.players(@@gg)
    game = TicTacToe::Game.new(*real_players)
  end
end

Mine.app :width => 400, :heigh => 500, :margin => 10
