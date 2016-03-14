require_relative '../lib/renderer'
require_relative '../lib/guess'
class ComputerGuess
  def initialize
    @render = Renderer.new
    @guessed = []
    @game_messages = []
    start_render
    @num_array = []
    play
  end

  def play
    select_a_range
    create_array(@low_num,@high_num)
    @game_messages.push("I will guess your number in #{Math.log(@high_num-@low_num).round} tries.")
    start_render
    make_guess(@num_array, @low_num, @high_num)
  end

  def start_render
    @render.title
    @render.render_guesses(@guessed)
    @render.render_guess_result(@game_messages)
  end

  def select_a_range
    @game_messages.push("Give me a range of numbers. Low end first!")
    start_render
    @low_num = get_low_num
    @game_messages.push("OK. Give me the high end now!")
    start_render
    @high_num = get_high_num
  end

  def get_low_num
    input = gets.chomp
    if input.to_i == 0
      @game_message.push("Give me a real number above 0")
      start_render
      get_low_num
    end
    return input.to_i
  end

  def get_high_num
    input = gets.chomp
    if input.to_i == 0 || input.to_i < @low_num
      @game_message.push("Give me a real number higher than the low number")
      start_render
      get_low_num
    end
    return input.to_i
  end

  def create_array(low_num,high_num)
    (low_num..high_num).each do |num|
      @num_array.push(num)
    end
  end

  def get_input
    @render.print_input("Is your number #{guess} 1. Higher - 2. Lower?")
    input = gets.chomp
    if input.to_i != 1 || input.to_i !=2
      @game_message.push("Enter a valid input")
      start_render
      get_input
    end
    return input.to_i
  end

  def make_guess(range, min, max)
    guess = (max+min)/2.round
    @render.print_input("Is your number #{guess} 1. Higher - 2. Lower?")
    input = get_input


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

ComputerGuess.new
