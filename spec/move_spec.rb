require 'spec_helper'

describe "Move" do
  before(:all) do
    @move = Move.new
  end
  
  it "sets correct rows from config" do
    expect(@move.instance_variable_get(:@rows)).to eq Configuration::ROWS
  end

  it "sets correct columns from config" do
    expect(@move.instance_variable_get(:@columns)).to eq Configuration::COLUMNS
  end

  it "sets correct height from config" do
    expect(@move.instance_variable_get(:@height)).to eq Configuration::HEIGHT
  end
end
