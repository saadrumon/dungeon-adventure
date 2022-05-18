require 'spec_helper'

describe "GameHelper" do
  context "constants" do
    it "expects EMPTY_CELL to be equal to 0" do
      expect(GameHelper::EMPTY_CELL).to eq 0
    end

    it "expects PLAYER_CELL to be equal to 1" do
      expect(GameHelper::PLAYER_CELL).to eq 1
    end

    it "expects ENEMY_CELL to be equal to 2" do
      expect(GameHelper::ENEMY_CELL).to eq 2
    end

    it "should not allow ENEMY_CELL to be equal to 0" do
      expect(GameHelper::ENEMY_CELL).not_to eq 0
    end

    it "expects DIALOG_HASH to be equal to parsed json from .env DIALOG variable " do
      expect(GameHelper::DIALOG_HASH).to eq JSON.parse(ENV["DIALOG"])
    end
  end

  context "utter method" do
    before(:all) do
      @dialog = JSON.parse(ENV['DIALOG'])
    end

    it "expects message to be printed in console" do
      expect{ GameHelper::utter("START") }.to output.to_stdout
    end

    it "prints START message to console" do
      expect{ GameHelper::utter("START") }.to output("#{ @dialog['START'].yellow }\n").to_stdout
    end

    it "prints WELCOME message to console" do
      expect{ GameHelper::utter("WELCOME") }.to output("#{ @dialog['WELCOME'].yellow }\n").to_stdout
    end

    it "prints DANGER message to console" do
      expect{ GameHelper::utter("DANGER") }.to output("#{ @dialog['DANGER'].red }\n").to_stdout
    end

    it "prints LEFT message to console" do
      expect{ GameHelper::utter("LEFT") }.to output("#{ @dialog['LEFT'].green }\n").to_stdout
    end

    it "prints RIGHT message to console" do
      expect{ GameHelper::utter("RIGHT") }.to output("#{ @dialog['RIGHT'].green }\n").to_stdout
    end

    it "prints FORWARD message to console" do
      expect{ GameHelper::utter("FORWARD") }.to output("#{ @dialog['FORWARD'].green }\n").to_stdout
    end

    it "prints BACKWARD message to console" do
      expect{ GameHelper::utter("BACKWARD") }.to output("#{ @dialog['BACKWARD'].green }\n").to_stdout
    end

    it "prints HIT message to console" do
      expect{ GameHelper::utter("HIT") }.to output("#{ @dialog['HIT'].green }\n").to_stdout
    end

    it "prints RUN message to console" do
      expect{ GameHelper::utter("RUN") }.to output("#{ @dialog['RUN'].red }\n").to_stdout
    end

    it "prints RESTART message to console" do
      expect{ GameHelper::utter("RESTART") }.to output("#{ @dialog['RESTART'].yellow }\n").to_stdout
    end

    it "prints EXIT message to console" do
      expect{ GameHelper::utter("EXIT") }.to output("#{ @dialog['EXIT'].red }\n").to_stdout
    end

    it "prints CHOICE message to console" do
      options = %w[enter exit]
      expect{ GameHelper::utter("CHOICE", options) }.to output("#{ @dialog['CHOICE'].blue }" + " (#{ options.join('/') })".red + "\n").to_stdout
    end

    it "prints FALLBACK message to console" do
      expect{ GameHelper::utter("FALLBACK") }.to output("#{ @dialog['FALLBACK'].red }\n").to_stdout
    end

    it "should not print any message except RANDOM ones" do
      expect{ GameHelper::utter("RANDOM") }.not_to output("#{ @dialog['RUN'].yellow }\n").to_stdout
    end
  end

  context "get_options method" do
    it "returns possible moves give a state of grid" do
      grid = [[0, 0, 0, 1], [0, 0, 2, 0], [0, 0, 0, 0]]
      possible_moves = ["right", "backward", "exit"]
      expect(GameHelper::get_options(grid)).to match_array possible_moves
    end

    it "returns possible moves give a state of grid" do
      grid = [[0, 0], [0, 0], [1, 2], [0, 0]]
      possible_moves = ["right", "left", "forward", "exit"]
      expect(GameHelper::get_options(grid)).to match_array possible_moves
    end

    it "doesn't return moves which are not possible" do
      grid = [[1, 0, 0], [0, 2, 0]]
      possible_moves = ["right", "left", "forward", "backward", "exit"]
      expect(GameHelper::get_options(grid)).not_to match_array possible_moves
    end
  end

  context "get_options method" do
    it "returns position of the player given a state of grid" do
      grid = [[0, 0, 0, 1], [0, 0, 2, 0], [0, 0, 0, 0]]
      row_player = 0
      col_player = 3
      ret_row_player, ret_col_player = GameHelper::get_player_position(grid)
      expect(ret_row_player).to eq row_player
      expect(ret_col_player).to eq col_player
    end

    it "returns position of the player given a state of grid" do
      grid = [[0, 0, 0, 0, 0], [0, 0, 2, 0, 0], [1, 0, 0, 0, 0], [0, 0, 0, 0, 0]]
      row_player = 2
      col_player = 0
      ret_row_player, ret_col_player = GameHelper::get_player_position(grid)
      expect(ret_row_player).to eq row_player
      expect(ret_col_player).to eq col_player
    end

    it "doesn't return incorrect position of the player given a state of grid" do
      grid = [[0, 0, 0, 0, 0], [0, 0, 2, 0, 1]]
      row_player = 1
      col_player = 0
      ret_row_player, ret_col_player = GameHelper::get_player_position(grid)
      expect(ret_row_player).to eq row_player
      expect(ret_col_player).not_to eq col_player
    end
  end
end
