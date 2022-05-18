require 'spec_helper'

describe "Right" do

  context "move method" do
    before(:all) do
      @right = Right.new
    end
    
    it "returns grid after changing player position to the right" do
      grid = [[0, 1, 0], [2, 0, 0], [0, 0, 0]]
      grid, is_enemy_cell = @right.move(grid)
      
      row_player_new = 1
      col_player_new = 1

      row_player, col_player = GameHelper::get_player_position(grid)

      expect(row_player).to eq row_player_new
      expect(col_player).to eq col_player_new
    end

    it "returns false for is_enemy_cell value if new cell is not enemy cell" do
      grid = [[0, 1, 0], [2, 0, 0], [0, 0, 0]]
      grid, is_enemy_cell = @right.move(grid)

      expect(is_enemy_cell).to eq false
    end

    it "returns true for is_enemy_cell value if new cell is enemy cell" do
      grid = [[0, 1, 0], [0, 2, 0], [0, 0, 0]]
      grid, is_enemy_cell = @right.move(grid)

      expect(is_enemy_cell).to eq true
    end

  end

end
