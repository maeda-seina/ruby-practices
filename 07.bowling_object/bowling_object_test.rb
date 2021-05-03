# frozen_string_literal: true

require './bowling_object'
require 'minitest/autorun'

class BowlingObjectTest < Minitest::Test
  def test_frame
    assert_equal 5, Frame.new(2, 3).calculate_frame_score
  end

  def test_only_frame_score
    score = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'.split(',')
    assert_equal 94, Game.new(score).calculate_game_score
    score = '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'.split(',')
    assert_equal 0, Game.new(score).calculate_game_score
    score = 'X,X,X,X,X,X,X,X,X,X,X,X'.split(',')
    assert_equal 120, Game.new(score).calculate_game_score
  end

  def test_only_bonus_score
    score = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'.split(',')
    assert_equal 45, Game.new(score).calculate_bonus_score
    score = '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'.split(',')
    assert_equal 0, Game.new(score).calculate_bonus_score
    score = 'X,X,X,X,X,X,X,X,X,X,X,X'.split(',')
    assert_equal 180, Game.new(score).calculate_bonus_score
  end

  def test_frame_strike?
    assert_equal true, Frame.new('X').strike?
    assert_equal false, Frame.new('0', 'X').strike?
    assert_equal false, Frame.new('1', '9').strike?
    assert_equal false, Frame.new('1', '2').strike?
  end

  def test_frame_spare?
    assert_equal true, Frame.new('0', 'X').spare?
    assert_equal true, Frame.new('1', '9').spare?
    assert_equal false, Frame.new('X').spare?
    assert_equal false, Frame.new('1', '2').spare?
  end
end
