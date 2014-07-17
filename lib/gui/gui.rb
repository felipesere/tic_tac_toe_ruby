require 'gui/cell'
require 'gui/board_view'
require 'tic_tac_toe/game'
require 'gui/main_pane'
require 'gui/game_pane'

module TTTGui

  def set_controller(controller)
    @@controller = controller
  end

end
