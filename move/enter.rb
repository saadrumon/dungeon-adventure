class Enter
  def move(grid)
    @grid = grid
    @total_rows = @grid.length
    @total_cols = @grid[0].length

    GameHelper::utter("WELCOME")
    
    set_enemy_position
    set_initial_player_position
    
    return @grid, false
  end

  private

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
