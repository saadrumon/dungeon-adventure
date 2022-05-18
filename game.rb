require "readline"
require "./game_helper"
require "dotenv"

Dotenv.load

Dir[File.join(File.dirname(__FILE__), "move", "*.rb")].each { |file| require file }


class Game
  def initialize
    @left = Left.new
    @right = Right.new
    @forward = Forward.new
    @backward = Backward.new
    @enter = Enter.new
    @valid_options = %w[enter exit]

    set_grid
  end

  def play
    GameHelper::utter("START")
    GameHelper::utter("CHOICE", @valid_options)

    while input = Readline.readline("> ", true).strip.downcase
      if input.eql? "exit"
        GameHelper::utter("EXIT")
        break
      elsif @valid_options.include? input
        @grid, is_enemy_cell = instance_variable_get("@#{input}").move(@grid)

        if is_enemy_cell
          process_final_action
          @valid_options = %[enter exit]
        else
          @valid_options = GameHelper::get_options(@grid)
        end

        GameHelper::utter("CHOICE", @valid_options)
      else
        GameHelper::utter("FALLBACK")
      end
      puts @grid.inspect
    end
    
  end

  private

  def set_grid
    total_rows = rand 2..ENV["MAX_ROW"].to_i
    total_cols = rand 2..ENV["MAX_COL"].to_i

    @grid = []
    total_rows.times do |row|
      arr = []
      total_cols.times { |col| arr << GameHelper::EMPTY_CELL }
      @grid << arr
    end
  end

  def process_final_action
    GameHelper::utter("DANGER")
    @valid_options = %w[hit run]
    GameHelper::utter("CHOICE", @valid_options)

    while input = Readline.readline("> ", true).strip.downcase
      if @valid_options.include? input
        GameHelper::utter(input.upcase)
        GameHelper::utter("RESTART")
        break
      else
        GameHelper::utter("FALLBACK")
      end
    end

  end
end

game = Game.new
game.play
