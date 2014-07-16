$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

require 'gui/gui'

class MyApp < Shoes
  include TTTGui

  url '/',      :main_menu
  url '/game',  :game
  url '/end',   :retry

  def main_menu


    visit '/game'
  end

  def game
    new_game
  end

  def retry
    visit '/'
  end
end

Shoes.app :title => "Tic Tac Toe", :width => 300, :height => 400, :margin => 10
