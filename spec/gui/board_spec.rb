require 'gui/board'
require 'gui/fakes'
require 'spec_helper'
require 'tic_tac_toe/board'

describe GUI::Board do
  let(:fake_shoes) { GUI::FakeApp.new }
  after(:each) { fake_shoes.reset }

  it "its images match the markings on a game board" do
    game_board = TicTacToe::Board.new [[:x,:x,:o],[nil, nil, nil],[nil, nil,nil]]
    board = GUI::Board.new(fake_shoes, game_board, GUI::FakeClicker.new)
    expect(fake_shoes.images_like(/x.jpg/).size).to eq 2
    expect(fake_shoes.images_like(/o.jpg/).size).to eq 1
  end
  
  it "passes the correct data to clickable cells" do
    game_board = TicTacToe::Board.new [[nil, nil, nil],[:x, :x, :x],[:x, :x, :x]]
    fake_clicker = GUI::FakeClicker.new
    board = GUI::Board.new(fake_shoes, game_board, fake_clicker)
    images = fake_shoes.images_like(/none/)
    images.each.with_index(1) do |image, move|
      image.click!
      expect(fake_clicker.click_data).to eq move
    end
  end
end
