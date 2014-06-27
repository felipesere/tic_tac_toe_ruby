require 'spec_helper'

describe CliInput do
  it "reads from input source" do
    fake = FakeSTDIN.new(["1"])
    input = CliInput.new(fake)
    expect(input.get_input).to eq 1
  end

  it "reads from input source" do
    fake = FakeSTDIN.new(["xyz", "1"])
    input = CliInput.new(fake)
    expect(input.get_input).to eq 1
  end

  class FakeSTDIN
    def initialize(inputs)
      @inputs = inputs.reverse
    end

    def read
      @inputs.pop
    end
  end
end
