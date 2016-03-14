require_relative '../lib/renderer'
require_relative '../lib/guess'
class HumanGuess
  def initialize
    @render = Renderer.new
    @guessed = []
    @game_messages = []
    start_render
  end

  def play
    select_a_number
    make_guess
  end

  def start_render
    @render.title
    @render.render_guesses(@guessed)
    @render.render_guess_results(@game_messages)
  end

  def select_a_number
    @game_messages.push("Pick a number between 1 and a 100. You have 3 seconds!")
    sleep 3
    @game_messages.push("Ready or not here I go!")
    sleep 1
  end

  def make_guess

  end
end

class Game
  def initialize
    @guess = Guess.new
    @render = Renderer.new
    start_render
    #play
  end

  def play
    input = get_input
    result = @guess.check_guess(input)
    check_game_end(result)
    start_render
    play
  end

  def start_render
    @render.title
    @render.render_guesses(@guess.player_guesses)
    @render.render_guess_result(@guess.guess_result)
  end

  def get_input
    @render.print_input("Please enter your guess here!")
    input = validate(gets.chomp)
  end

  def validate(input)
    case input.to_i
    when (1..100)
      return input.to_i
    else
      @render.print_str("Please enter a valid input")
      get_input
    end
  end

  def check_game_end(result)
    if result == "win"
      @guess.guess_result.push("You win! You guessed my Number")
      game_end
    elsif result == 5
      @guess.guess_result.push("You used up all your guesses! You lose\nMy number was #{@guess.ai_guess}")
      game_end
    end
  end

  def game_end
    start_render
    @render.print_input("Would you like to (P)lay again? or (Q)uit?")
    input = validate_replay(gets.chomp)
  end

  def validate_replay(input)
    case input.upcase
    when "P"
      @guess = Guess.new
      start_render
      play
    when "Q"
      exit
    end
  end
end


Game.new
