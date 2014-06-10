require 'spec_helper'
require 'tic_tac_toe_ruby'

describe TicTacToeRuby do
  it "should have a VERSION constant" do
    subject.const_get('VERSION').should_not be_empty
  end
end
