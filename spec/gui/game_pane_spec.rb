require 'gui/game_pane'
require 'spec_helper'
require 'gui/fakes'

describe GUI::GamePane do
  let(:fake_shoes) { fake_shoes = GUI::FakeApp.new  }
  let(:pane) { pane = GUI::GamePane.new(fake_shoes, nil) }

  it "calls a block once the game is finsihed" do
    inner_block_called = false
    pane.play_on(FakeGame.new(runs: 0)) do 
      inner_block_called = true
    end

    fake_shoes.animation.run!
    expect(fake_shoes.animation).to be_stopped
    expect(inner_block_called).to eq true
  end

  it "draws nine images on the board" do
    pane.draw(TicTacToe::Board.create_empty)
    expect(fake_shoes.images.size).to eq 9 
  end
  
  it "given the game is ready, then it will tick forward" do
     game = FakeGame.new(runs: 1, ready: true)
     pane.animate(game, nil)  
     expect(game).to be_ticked
  end

  class FakeGame
    def initialize(params)
      @runs = params[:runs] || 0
      @ready = params[:ready] || false
    end

    def is_finished?
      @runs.zero?
    end

    def tick
      @runs -= 1
      @ticked = true
    end

    def ticked?
      @ticked
    end

    def ready?
      @ready
    end

    def current_board
      TicTacToe::Board.create_empty
    end
  end
end
