require "dotenv"
require "json"
require "colorize"

Dotenv.load

module GameHelper

  EMPTY_CELL = 0
  PLAYER_CELL = 1
  ENEMY_CELL = 2

  DIALOG_HASH = JSON.parse(ENV['DIALOG'])

  def self.utter(utter_type, options=[])
    message = (utter_type.eql? "RANDOM") ?
      DIALOG_HASH["RANDOM"][rand 0...DIALOG_HASH["RANDOM"].length] :
      DIALOG_HASH[utter_type]

    if utter_type.eql? "CHOICE" 
      puts message.blue + " (#{ options.join('/') })".red if options.any?
    elsif %w[LEFT RIGHT FORWARD BACKWARD HIT].include? utter_type
      puts message.green
    elsif %w[DANGER FALLBACK RUN EXIT].include? utter_type
      puts message.red
    else
      puts message.yellow
    end
  end

  def self.get_options(grid)
    row_player, col_player = get_player_position(grid)
    options = []
    options << "left" if (row_player - 1) >= 0 
    options << "right" if (row_player + 1) < grid.length 
    options << "backward" if (col_player - 1) >= 0 
    options << "forward" if (col_player + 1) < grid[0].length
    options << "exit"
    options
  end

  def self.get_player_position(grid)
    row_player = -1
    col_player = -1
    grid.length.times do |row|
      grid[0].length.times do |col|
        if grid[row][col].eql? PLAYER_CELL
          row_player = row
          col_player = col
        end
      end
    end

    return row_player, col_player
  end

end
