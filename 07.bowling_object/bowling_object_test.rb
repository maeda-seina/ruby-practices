# frozen_string_literal: true

require './shot'
require './frame'
require './game'
require 'minitest/autorun'

class BowlingObjectTest < Minitest::Test
  def test_game_score
    score = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'.split(',')
    assert_equal 139, Game.new(score).calculate_game_score
    score = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X'.split(',')
    assert_equal 164, Game.new(score).calculate_game_score
    score = '0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4'.split(',')
    assert_equal 107, Game.new(score).calculate_game_score
    score = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0'.split(',')
    assert_equal 134, Game.new(score).calculate_game_score
    score = '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'.split(',')
    assert_equal 0, Game.new(score).calculate_game_score
    score = 'X,X,X,X,X,X,X,X,X,X,X,X'.split(',')
    assert_equal 300, Game.new(score).calculate_game_score
  end

  def test_only_bonus_score
    score = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'.split(',')
    assert_equal 45, Game.new(score).calculate_bonus_score
    score = '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'.split(',')
    assert_equal 0, Game.new(score).calculate_bonus_score
    score = 'X,X,X,X,X,X,X,X,X,X,X,X'.split(',')
    assert_equal 180, Game.new(score).calculate_bonus_score
  end
end
