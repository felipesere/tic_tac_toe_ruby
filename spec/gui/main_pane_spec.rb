require 'gui/fakes'
require 'gui/main_pane'
require 'spec_helper'

describe GUI::MainPane do
  let(:fake_shoes) { GUI::FakeApp.new }
  before(:each) { fake_shoes.reset }


  it "prepares the the player combinations for the GUI" do
    gui = GUI::MainPane.new(fake_shoes, false)
    first = [:a, :b]
    second = [:c, :d]
    result = gui.convert_players_for_ui [first, second]
    expect(result).to eq ({ "a vs. b" => first,
                            "c vs. d" => second })
  end

  it "properly presents the player options to the user" do
    input = { [:a, :b] => "a vs. b",
              [:c, :d] => "c vs. d"}
    GUI::MainPane.new(fake_shoes, input.keys).draw
    expect(users_choice.items).to include(*input.values)
  end

  it "yields the selected players when clicking the button" do
    gui = GUI::MainPane.new(fake_shoes, [[:a, :b]])
    gui.draw do |players|
      expect(players).to eq [:a, :b]
    end
    fake_shoes.click_on("Play!")
  end

  def users_choice
    fake_shoes.list_boxes.first
  end
end
