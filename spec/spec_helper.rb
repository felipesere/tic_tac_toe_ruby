require 'rspec'

require 'simplecov'

SimpleCov.start do
  add_filter "spec"
end


require 'rspec/expectations'

RSpec::Matchers.define :have do |expected|
  match do |actual|
    if expected == :stack
      first_stack = actual.stacks.first
      @args.each do |sub_component|
        first_stack[sub_component]
      end
      true
    end
  end
  chain :containing do |*args|
    @args = args
  end
end
