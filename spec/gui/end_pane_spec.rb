require 'gui/end_pane'
require 'gui/fakes'
require 'tic_tac_toe/board'

describe GUI::EndPane do
  it "has two buttons" do
    fake_shoes = GUI::FakeApp.new
    GUI::EndPane.new(fake_shoes, winning_board_for(:x))
    expect(fake_shoes.buttons.size).to eq 2
  end

  { 
    'Play again' => :replay,
    'Main menu' => :menu 
  }.each do |button, value|
    it "yields :#{value} when '#{button}' is clicked" do
      fake_shoes = GUI::FakeApp.new
      GUI::EndPane.new(fake_shoes, winning_board_for(:x)) { |value|  expect(value).to eq value }
      fake_shoes.click_on(button)
    end
  end

  [:x, :o].each do |player|
    it "announces the winner for #{player}" do
      fake_shoes = GUI::FakeApp.new
      board = winning_board_for(player)
      GUI::EndPane.new(fake_shoes, board) 
      expect(fake_shoes.messages).to include "#{player} won"
    end
  end

  it "announces a draw" do
    fake_shoes = GUI::FakeApp.new
    board = TicTacToe::Board.new [[:x, :o, :x],
                                  [:x, :o, :o],
                                  [:o, :x, :o]]
    GUI::EndPane.new(fake_shoes, board) 
    expect(fake_shoes.messages).to include "there was a draw"
  end

  def winning_board_for(player)
    TicTacToe::Board.new [[player, player, player], Array.new(3), Array.new(3)]
  end
end
