require 'spec_helper'

describe "Enter" do
  before(:all) do
    @enter = Enter.new
  end

  context "move method" do
    it "returns grid with one enemy and one player position" do
      grid, is_enemy_cell = @enter.move(nil)
      enemy_count = 0
      player_count = 0
      grid.length.times do |row|
        grid[0].length.times do |col|
          enemy_count += 1 if grid[row][col] == GameHelper::ENEMY_CELL
          player_count += 1 if grid[row][col] == GameHelper::PLAYER_CELL
        end
      end

      expect(enemy_count).to eq 1
      expect(player_count).to eq 1
    end

    it "returns false for the value of is_enemy_cell" do
      grid, is_enemy_cell = @enter.move(nil)
      expect(is_enemy_cell).to eq false
    end
  end
  
  context "set_grid method creates a grid" do
    before(:each) do
      @enter.send(:set_grid)
      @grid = @enter.instance_variable_get(:@grid)
      @total_rows = @enter.instance_variable_get(:@total_rows)
      @total_cols = @enter.instance_variable_get(:@total_cols)
    end

    it "where number of rows equals @total_rows instance variable value" do
      expect(@total_rows).to eq @grid.length
    end

    it "where number of columns equals @total_cols instance variable value" do
      expect(@total_cols).to eq @grid[0].length
    end

    it "where number of rows does not differ from @total_row" do
      expect(@total_cols).not_to eq @grid[0].length + 1
    end

    it "which is a 2D matrix with value of GameHelper::EMPTY_CELL" do
      @total_rows.times do |row|
        @total_cols.times do |col|
          expect(@grid[row][col]).to eq GameHelper::EMPTY_CELL
        end
      end
    end

    it "where number of rows is less than or equal to MAX_ROW environment variable" do
      expect(@grid.length).to be <= ENV["MAX_ROW"].to_i
    end

    it "where number of columns is less than or equal to MAX_COL environment variable" do
      expect(@grid[0].length).to be <= ENV["MAX_COL"].to_i
    end
  end

  context "set_enemy_position method" do
    before(:each) do
      @enter.send(:set_enemy_position)
      @grid = @enter.instance_variable_get(:@grid)
      @total_rows = @enter.instance_variable_get(:@total_rows)
      @total_cols = @enter.instance_variable_get(:@total_cols)
    end
    
    it "sets enemy position which is not outside of grid" do
      row_enemy = -1
      col_enemy = -1
      @total_rows.times do |row|
        @total_cols.times do |col|
          if @grid[row][col].eql? GameHelper::ENEMY_CELL
            row_enemy = row
            col_enemy = col
          end
        end
      end

      expect(row_enemy).to be < @total_rows 
      expect(row_enemy).to be >= 0
      expect(col_enemy).to be < @total_cols 
      expect(col_enemy).to be >= 0       
    end
  end

  context "set_initial_player_position method" do
    before(:each) do
      @enter.send(:set_initial_player_position)
      @grid = @enter.instance_variable_get(:@grid)
      @total_rows = @enter.instance_variable_get(:@total_rows)
      @total_cols = @enter.instance_variable_get(:@total_cols)
      @row_player, @col_player = GameHelper::get_player_position(@grid)
    end

    it "sets initial player position which is not equal to enemy position" do
      row_enemy = -1
      col_enemy = -1
      @total_rows.times do |row|
        @total_cols.times do |col|

          if @grid[row][col].eql? GameHelper::ENEMY_CELL
            row_enemy = row
            col_enemy = col
          end
        end
      end

      equal_position_flag = (row_enemy == @row_player && col_enemy == @col_player) ?
        true :
        false

      expect(equal_position_flag).to eq false 
    end
    
    it "sets initial player position which is not outside of grid" do
      expect(@row_player).to be < @total_rows 
      expect(@row_player).to be >= 0
      expect(@col_player).to be < @total_cols 
      expect(@col_player).to be >= 0       
    end
  end

end
