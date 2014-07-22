require 'gui/fakes'
require 'gui/main_pane'
require 'spec_helper'

describe GUI::MainPane do
  xit "has the right layout structure" do
    app = GUI::FakeApp.new
    GUI::MainPane.new(app, false)
    expect(app).to have(:stack).containing(:para, :list_box, :button)
  end

  it "prepares the the player combinations for the GUI" do
    gui = GUI::MainPane.new(GUI::FakeApp.new, false)
    first = [:a, :b]
    second = [:c, :d]
    result = gui.convert_players_for_ui [first, second]
    expect(result).to eq ({ first => "a vs. b",
                           second => "c vs. d" })
  end

  it "yields the selected players when clicking the button" do
    fake_shoes = GUI::FakeApp.new
    fake_factory = FakeFactory.new([[:a, :b]])
    gui = GUI::MainPane.new(fake_shoes, fake_factory)
    gui.draw do |players|
      expect(players).to eq [:a, :b]
    end
    fake_shoes.click_on("Play!")
  end

  class FakeFactory
    def initialize(combinations)
      @combinations = combinations
    end
    def player_combinations
      @combinations
    end
  end
end
