require 'spec_helper'
require 'tic_tac_toe/board'

describe TicTacToe::Board do
  let(:board) { TicTacToe::BoardFactory.create_empty }
  let(:drawn_board) { board = TicTacToe::Board.create [[:x, :x, :o],
                                                       [:o, :o, :x], 
                                                       [:x, :o, :x]] }

  context '#perform_move' do
    let(:move) { board.possible_moves.first }
    let(:marked_board) { board.perform_move :x, move }

    it 'returns a new/different board' do
      expect(marked_board).not_to be board
    end

    context '#possible_moves' do
      let(:moves_before) { board.possible_moves.size }

      it 'reduces the number of possible moves' do
        expect(marked_board.possible_moves.size).to be(moves_before - 1)
      end

      it 'has no possible moves for full board' do
        expect(drawn_board.possible_moves.empty?).to be true
      end
    end
  end

  context "#create" do
    it "allows creating specific boards" do
      board = TicTacToe::Board.create [[:x, :x, :x ],
                                       [:x, :x, :x ],
                                       [:x, :x, nil]]
      expect(board.possible_moves.size).to eq 1
    end
  end

  context "#has_winner" do
  
    it "has no winner" do
      board = TicTacToe::Board.create [[ :x , :x , nil ],
                                       [ nil, nil, nil ],
                                       [ nil, nil, nil ]]
      expect(board.has_winner?).to eq false
    end
    
    it "has winner for three horizontal" do
      board = TicTacToe::Board.create [[ :x , :x , :x ],
                                       [ nil, nil, nil ],
                                       [ nil, nil, nil ]]
      expect(board.has_winner?).to eq true
      expect(board.is_winner?(:x)).to eq true
      expect(board.is_winner?(:o)).to eq false
    end

  

    it "has winner for three vertical" do
      board = TicTacToe::Board.create [[ :x , nil , nil ],
                                       [ :x, nil, nil ],
                                       [ :x, nil, nil ]]
      expect(board.has_winner?).to eq true
    end

    it "has winner for first diagonal" do
      board = TicTacToe::Board.create [[ :x , nil , nil ],
                                       [ nil, :x, nil ],
                                       [ nil, nil, :x ]]
      expect(board.has_winner?).to eq true
    end

    it "has winner for second diagonal" do
      board = TicTacToe::Board.create [[ nil , nil , :x],
                                       [ nil , :x,  nil ],
                                       [ :x  , nil, nil ]]
      expect(board.has_winner?).to eq true
    end
    it "has no winner for a draw" do
      expect(drawn_board.has_winner?).to eq false
      expect(drawn_board.has_draw?).to eq true
      expect(drawn_board.is_finished?).to eq true
    end
  end
end
