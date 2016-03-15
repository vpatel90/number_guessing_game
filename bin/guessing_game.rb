require_relative '../lib/renderer'
require_relative '../lib/guess'
require_relative '../lib/game'
require_relative '../lib/ComputerGuess'
require_relative '../paint/lib/paint.rb'

class GameStateManager

  def initialize
    @renderer = Renderer.new
    menu
  end

  def menu
    @menu = ["1. Guess a Number between 1 and 100", "2. Have AI Guess Your Number", "3. Quit"]
    start_render
    input = get_input
    if input == 1
      startGame
    elsif input == 2
      startComputerGUess
    elsif input == 3
      exit
    else
      menu
    end
  end

  def start_render
    @renderer.title
    @renderer.render_menu(@menu)
  end

  def get_input
    @renderer.print_input("Make your selection")
    input = gets.chomp
    if input.to_i < 0 || input.to_i>3
      get_input
    end
    return input.to_i
  end

  def startGame
    Game.new.play
    menu
  end

  def startComputerGUess
    ComputerGuess.new.play
    menu
  end
end

GameStateManager.new
