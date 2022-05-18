class Left

  def move(grid)
    row_player, col_player = GameHelper::get_player_position(grid)
    
    is_enemy_cell = false
    
    GameHelper::utter("LEFT")
    
    if grid[row_player - 1][col_player].eql? GameHelper::ENEMY_CELL
      is_enemy_cell = true
    else
      GameHelper::utter("RANDOM")
      grid[row_player][col_player] = GameHelper::EMPTY_CELL
      grid[row_player - 1][col_player] = GameHelper::PLAYER_CELL
    end
    
    return grid, is_enemy_cell
  end

end
