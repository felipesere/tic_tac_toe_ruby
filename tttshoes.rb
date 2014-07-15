require 'lib/tic_tac_toe/board'


Shoes.app :width => 280, :height => 350 do

  def make_random_move
    move = @board.possible_moves.sample
    @board = @board.perform_move(@players.first, move)
    @players.rotate!
  end

  def clear_board
    @the_pane.clear
  end

  def draw_board
    running_index = 1
    @the_pane = stack do
      @board.rows.each do |row|
        flow :width => 280, :margin => 10 do
          row.each do |cell|
            element = stack :width => "33%" do
              image_for_cell(cell)
            end 
            here = running_index
            running_index += 1
            element.click do
              attempt_move(here)
            end
          end
        end
      end
    end
  end

  def image_for_cell(cell)
    if !cell.nil?
      image "assets/#{cell}.jpg"
    else
      image "assets/none.jpg"
    end
  end

  def attempt_move(move)
    moves = @board.possible_moves
    p "move: #{move}"
    p @board
    if moves.include? move
      make_move(move)
      clear_board
      draw_board
    end
  end

  def make_move(move)
    @board = @board.perform_move(@players.first, move)
    @players.rotate!
  end

  @players = [:x, :o]
  background white
  @board = TicTacToe::Board.create_empty
  3.times do
    make_random_move
  end 
  draw_board
end
