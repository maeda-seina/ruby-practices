# frozen_string_literal: true

require './bowling_object'
require 'minitest/autorun'

class BowlingObjectTest < Minitest::Test
  def test_frame
    assert_equal 5, Frame.new(2, 3).calc_frame_score
  end
end