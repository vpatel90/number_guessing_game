require 'minitest/autorun'
require 'minitest/pride'

require_relative '../bin/guessing_game.rb'

class TestGame < Minitest::Test

  def setup
    @game = Game.new
    @guess = Guess.new
  end

  def test_validate
    assert_equal(50,50)
    assert_equal(25,25)
    assert_equal(15,15)
  end

  def test_guess
    expected = Fixnum
    actual = @guess.ai_guess.class
    assert_equal(expected, actual)
  end

  def test_check_guess
    @guess.ai_guess = 50
    expected1 = "win"
    expected2 = 2
    expected3 = 3

    assert_equal(expected1, @guess.check_guess(50))
    assert_equal(expected2, @guess.check_guess(70))
    assert_equal(expected3, @guess.check_guess(30))
  end

  def test_check_guess_with_arr
    @guess.ai_guess = 50
    @guess.player_guesses = [25,75]
    assert_equal(3, @guess.check_guess(20))

  end

  def test_check_too_high
    @guess.ai_guess = 50
    @guess.player_guesses = [25,75]
    assert_equal(@guess.guess_result.push("You are wasting your choice"), @guess.check_too_high(80))
    assert_equal(@guess.guess_result.push("You are guessing lower than your other low!"), @guess.check_too_low(20))
  end

  def test_validate_replay
    expected = nil
    assert_equal(expected,@game.validate_replay('x'))
    expected1 = nil
    assert_equal(expected,@game.validate_replay('m'))
  end
end
