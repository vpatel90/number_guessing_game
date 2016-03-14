require_relative '../lib/renderer'


class Game
  def initialize
    @guess = Guess.new
    @render = Renderer.new
    start_render
    play
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
      @guess.guess_result.push("You used up all your guesses! You lose")
      @guess.guess_result.push("My number was #{@guess.ai_guess}")
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

class Guess
  attr_accessor :ai_guess, :player_guesses, :guess_result
  def initialize
    @ai_guess = rand(1..100)
    @player_guesses = []
    @guess_result = []
  end

  def check_guess(input)
    if input == @ai_guess
      correct_guess
      result = "win"
    elsif input > @ai_guess
      high_guess
      check_too_high(input)
      @player_guesses.push(input)
      result = @player_guesses.length
    else
      low_guess
      check_too_low(input)
      @player_guesses.push(input)
      result = @player_guesses.length
    end
    return result
  end

  def check_too_high(input)
    if @player_guesses.length > 0 && @player_guesses.max > @ai_guess && input > @player_guesses.max
      @guess_result.push("You are wasting your choice")
    end
  end

  def check_too_low(input)
    if @player_guesses.length > 0 && @player_guesses.min < @ai_guess && input < @player_guesses.min
      @guess_result.push("You are choosing lower than your other low!")
    end
  end

  def correct_guess
    return @guess_result.push("You guessed right!")
  end

  def high_guess
    return @guess_result.push("Your guess is too high!")
  end

  def low_guess
    return @guess_result.push("Your guess is too low!")
  end




end

Game.new
