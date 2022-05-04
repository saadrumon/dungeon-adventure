require "readline"
require "./move.rb"


class Game

  def initialize
    @move = Move.new
  end

  def play
    @move.begin

    while input = Readline.readline("> ", true).strip.downcase
      case input
      when "yes"
        @move.enter
      when "left"
        @move.left
      when "right" 
        @move.right
      when "forward"
        @move.forward
      when "backward"
        @move.backward
      when "up"
        @move.up
      when "down" 
        @move.down
      when "exit"
        @move.end
        break
      when "pos"
        @move.position
      else
        @move.fallback
      end
    end
  end

end

game = Game.new
game.play
