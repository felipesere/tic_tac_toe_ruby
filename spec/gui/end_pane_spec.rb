require 'gui/end_pane'
require 'gui/fakes'

describe GUI::EndPane do
  it "has two buttons" do
    fake_shoes = GUI::FakeApp.new
    GUI::EndPane.new(fake_shoes)
    expect(fake_shoes.buttons.size).to eq 2
  end
  
  { 
    'Play again' => :replay,
    'Main menu' => :menu 
  }.each do |button, value|
    it "yields :#{value} when '#{button}' is clicked" do
      fake_shoes = GUI::FakeApp.new
      GUI::EndPane.new(fake_shoes) do |value|
        expect(value).to eq value
      end
      fake_shoes.click_on(button)
    end
  end
end
