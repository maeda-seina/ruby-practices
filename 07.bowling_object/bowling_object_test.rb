# frozen_string_literal: true

require './bowling_object'
require 'minitest/autorun'

class BowlingObjectTest < Minitest::Test
  def test_frame
    assert_equal 5, Frame.new(2, 3).calculate_frame_score
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
