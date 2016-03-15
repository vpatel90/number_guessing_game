class Guess
  attr_accessor :ai_guess, :player_guesses, :guess_result
  def initialize
    @ai_guess = rand(1..100)
    @player_guesses = []
    @guess_result = []
  end

  def check_guess(input)
    if player_guesses.index(input)
      @guess_result.push("Are you ok...")
      @player_guesses.push(input)
    else
      if input == @ai_guess
        correct_guess
        @player_guesses.push(input)
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
