require 'gui/game_pane'
require 'spec_helper'
require 'gui/fakes'

describe GUI::GamePane do
  let(:fake_shoes) { fake_shoes = GUI::FakeApp.new  }
  let(:pane) { pane = GUI::GamePane.new(fake_shoes) }

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

  it "redraws the board by clearing it" do
    empty = TicTacToe::Board.create_empty
    other = TicTacToe::Board.new [[:x, :o, :x],[nil, nil, nil],[nil, nil, nil]]
    pane.draw(empty)
    pane.redraw(other)
    expect(fake_shoes.images_like(/x/).size).to eq 2
  end

  class FakeGame
    def initialize(params)
      @runs = params[:runs] || 0
    end

    def is_finished?
      @runs.zero?
    end

    def tick
      @runs -= 1
    end

    def current_board
      TicTacToe::Board.create_empty
    end
  end
end
