require_relative '../game.rb'

RSpec.configure do |config|
  config.before(:each) do
    allow($stdout).to receive(:puts)
    allow($stdout).to receive(:write)
  end
end
