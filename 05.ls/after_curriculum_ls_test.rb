require './after_curriculum_ls'
require 'minitest/autorun'

class AfterCurriculumLsTest < Minitest::Test
    def test_ls
        assert_equal 1, Ls.new.test
    end
end
