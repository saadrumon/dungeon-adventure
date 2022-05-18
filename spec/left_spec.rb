require 'spec_helper'

describe "Left" do

  context "move method" do
    before(:all) do
      @left = Left.new
    end
    
    it "returns grid after changing player position to the left" do
      grid = [[0, 0], [2, 1]]
      grid, is_enemy_cell = @left.move(grid)
      
      row_player_new = 0
      col_player_new = 1

      row_player, col_player = GameHelper::get_player_position(grid)

      expect(row_player).to eq row_player_new
      expect(col_player).to eq col_player_new
    end

    it "returns false for is_enemy_cell value if new cell is not enemy cell" do
      grid = [[0, 0], [2, 1]]
      grid, is_enemy_cell = @left.move(grid)

      expect(is_enemy_cell).to eq false
    end

    it "returns true for is_enemy_cell value if new cell is enemy cell" do
      grid = [[0, 2], [0, 1]]
      grid, is_enemy_cell = @left.move(grid)

      expect(is_enemy_cell).to eq true
    end

  end

end
