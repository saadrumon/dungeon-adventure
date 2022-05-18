class Enter
  def move(grid)
    @grid = grid
    GameHelper::utter("WELCOME")
    
    set_grid
    set_enemy_position
    set_initial_player_position
    
    return @grid, false
  end

  private

  def set_grid
    @total_rows = rand 2..ENV["MAX_ROW"].to_i
    @total_cols = rand 2..ENV["MAX_COL"].to_i

    @grid = []
    @total_rows.times do |row|
      arr = []
      @total_cols.times { |col| arr << GameHelper::EMPTY_CELL }
      @grid << arr
    end
  end

  def set_enemy_position
    row_enemy = rand 0...@total_rows
    col_enemy = rand 0...@total_cols

    @grid[row_enemy][col_enemy] = GameHelper::ENEMY_CELL
  end

  def set_initial_player_position
    while true
      row_player = rand 0...@total_rows
      col_player = rand 0...@total_cols

      unless @grid[row_player][col_player].eql? GameHelper::ENEMY_CELL
        @grid[row_player][col_player] = GameHelper::PLAYER_CELL
        break
      end
    end
  end

end
