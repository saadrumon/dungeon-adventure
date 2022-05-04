require './config.rb'


class Move
  def initialize
    @rows = Configuration::ROWS
    @columns = Configuration::COLUMNS
    @height = Configuration::HEIGHT
    
    set_initial_positions
  end

  def position
    puts "X COORD: #{@x_coord}"
    puts "Y COORD: #{@y_coord}"
    puts "Z COORD: #{@z_coord}"
  end

  def begin
    utter_start
  end

  def enter
    utter_welcome
    utter_options
  end

  def left
    unless valid_position?(@x_coord - 1, @y_coord, @z_coord)
      utter_fallback
      return
    end

    @x_coord -= 1
    
    if enemy_position?
      utter_danger
      process_final_action
      return 
    end
    
    utter_random
    utter_options
  end

  def right
    unless valid_position?(@x_coord + 1, @y_coord, @z_coord)
      utter_fallback
      return
    end

    @x_coord += 1

    if enemy_position?
      utter_danger
      process_final_action
      return 
    end

    utter_random
    utter_options
  end

  def backward
    unless valid_position?(@x_coord, @y_coord - 1, @z_coord)
      utter_fallback
      return
    end

    @y_coord -= 1
    
    if enemy_position?
      utter_danger
      process_final_action
      return 
    end

    utter_random
    utter_options
  end

  def forward
    unless valid_position?(@x_coord, @y_coord + 1, @z_coord)
      utter_fallback
      return
    end

    @y_coord += 1
    
    if enemy_position?
      utter_danger
      process_final_action
      return 
    end
    
    utter_random
    utter_options
  end

  def down
    unless valid_position?(@x_coord, @y_coord, @z_coord - 1)
      utter_fallback
      return
    end

    @z_coord -= 1
    
    if enemy_position?
      utter_danger
      process_final_action
      return 
    end
    
    utter_random
    utter_options
  end

  def up
    unless valid_position?(@x_coord, @y_coord, @z_coord + 1)
      utter_fallback
      return
    end

    @z_coord += 1
    
    if enemy_position?
      utter_danger
      process_final_action
      return
    end
    
    utter_random
    utter_options
  end

  def end
    utter_exit
  end

  def fallback
    utter_fallback
  end

  private

  def utter_start
    options = ["yes", "exit"]
    puts "#{Configuration::DIALOG["START"]} (#{options.join('/')})."
  end

  def utter_welcome
    puts Configuration::DIALOG["WELCOME"]
  end

  def utter_random
    len = Configuration::DIALOG["OTHER"].length 
    puts Configuration::DIALOG["OTHER"][rand 0...len]
  end

  def utter_danger
    options = ["hit", "run"]
    puts "#{Configuration::DIALOG["DANGER"]} (#{options.join('/')})."
  end

  def utter_hit
    options = ["yes", "exit"]  
    puts "#{Configuration::DIALOG["HIT"]} (#{options.join('/')})."
  end

  def utter_run
    options = ["yes", "exit"]
    puts "#{Configuration::DIALOG["RUN"]} (#{options.join('/')})."
  end

  def utter_exit
    puts Configuration::DIALOG["EXIT"]
  end

  def utter_options
    options = []
    options << "left" if valid_position?(@x_coord - 1, @y_coord, @z_coord)
    options << "right" if valid_position?(@x_coord + 1, @y_coord, @z_coord)
    options << "backward" if valid_position?(@x_coord, @y_coord - 1, @z_coord)
    options << "forward" if valid_position?(@x_coord, @y_coord + 1, @z_coord)
    options << "down" if valid_position?(@x_coord, @y_coord, @z_coord - 1)
    options << "up" if valid_position?(@x_coord, @y_coord, @z_coord + 1)
    options << "exit"
    options = options.join('/')
    puts "#{Configuration::DIALOG["GO"]} (#{options})."
  end

  def utter_fallback
    puts Configuration::DIALOG["FALLBACK"]
  end

  def set_initial_positions
    @enemy_x = rand 0...@rows
    @enemy_y = rand 0...@columns
    @enemy_z = rand 0...@height
    @x_coord = @rows / 2
    @y_coord = @columns / 2
    @z_coord = @height / 2
  end

  def valid_position?(x, y, z)
    (0...@rows).include? x and (0...@columns).include? y and (0...@height).include? z
  end

  def enemy_position?
    @x_coord == @enemy_x and @y_coord == @enemy_y and @z_coord == @enemy_z
  end

  def process_final_action
    while input = Readline.readline("> ", true).strip.downcase
      if input.eql? "hit"
        utter_hit
        set_initial_positions
        break
      elsif input.eql? "run"
        utter_run
        set_initial_positions
        break
      else
        utter_fallback
      end
    end
  end

end
