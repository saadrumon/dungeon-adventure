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
  end

  def play
    GameHelper::utter("START")
    GameHelper::utter("CHOICE", @valid_options)

    grid = nil
    while input = Readline.readline("> ", true).strip.downcase
      if input.eql? "exit"
        GameHelper::utter("EXIT")
        break
      elsif @valid_options.include? input
        grid, is_enemy_cell = instance_variable_get("@#{input}").move(grid)

        if is_enemy_cell
          process_final_action
        else
          @valid_options = GameHelper::get_options(grid)
        end

        GameHelper::utter("CHOICE", @valid_options)
      else
        GameHelper::utter("FALLBACK")
      end
      puts grid.inspect
    end
    
  end

  private

  def process_final_action
    GameHelper::utter("DANGER")
    @valid_options = %w[hit run]
    GameHelper::utter("CHOICE", @valid_options)

    while input = Readline.readline("> ", true).strip.downcase
      if @valid_options.include? input
        GameHelper::utter(input.upcase)
        GameHelper::utter("RESTART")
        @valid_options = %w[enter exit]
        break
      else
        GameHelper::utter("FALLBACK")
      end
    end

  end
end

if $PROGRAM_NAME == __FILE__
  game = Game.new
  game.play
end 
