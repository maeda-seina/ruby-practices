# frozen_string_literal: true

require './ls_object'
require 'minitest/autorun'

class LsObjectTest < Minitest::Test
  def test_ls
    assert_equal 1, Ls.new.test
  end
end
