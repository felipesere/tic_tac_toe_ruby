require 'gui/cell'
require 'gui/fakes'
require 'spec_helper'

describe GUI::Cell do

  let(:fake_shoes) { GUI::FakeApp.new }

  [:x, :o].each do |var|
    context "Cell with #{var} marker" do
      let(:clicker) { GUI::FakeClicker.new }

      it "loads the correct image" do
        GUI::Cell.new(fake_shoes, var, clicker, 1)
        image = fake_shoes.images.first
        expect(image.path).to include "#{var}.jpg"
      end

      it "does not react to clicks" do
        GUI::Cell.new(fake_shoes, var, clicker, 1)
        fake_shoes.images.first.click!
        expect(clicker).not_to be_clicked
      end
    end
  end

  context "Cell with no marking" do
    let(:clicker) { clicker = GUI::FakeClicker.new }
    it "loads the correct image" do
      GUI::Cell.new(fake_shoes, nil, clicker, 1)
      image = fake_shoes.images.first
      expect(image.path).to include "none.jpg"
    end
    it "allows clicks" do
      cell = GUI::Cell.new(fake_shoes, nil, clicker, 1)
      fake_shoes.images.first.click!
      expect(clicker).to be_clicked
    end
  end


end
