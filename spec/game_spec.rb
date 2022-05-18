require 'spec_helper'

describe "Game" do
  before(:all) do
    @game = Game.new
  end
  
  it "should create an instance of Left class" do
    expect(@game.instance_variable_get(:@left)).to be_a Left
  end

  it "should create an instance of Right class" do
    expect(@game.instance_variable_get(:@right)).to be_a Right
  end

  it "should create an instance of Forward class" do
    expect(@game.instance_variable_get(:@forward)).to be_a Forward
  end

  it "should create an instance of Backward class" do
    expect(@game.instance_variable_get(:@backward)).to be_a Backward
  end

  it "should create an instance of Enter class" do
    expect(@game.instance_variable_get(:@enter)).to be_a Enter
  end

  it "should initially create @valid_options with enter and exit options" do
    expect(@game.instance_variable_get(:@valid_options)).to eq %w[enter exit]
  end
end
