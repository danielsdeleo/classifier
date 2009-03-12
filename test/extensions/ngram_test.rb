require "test/unit"
require File.dirname(__FILE__) + '/../test_helper'

class StringNGramExtensionsTest < Test::Unit::TestCase
  def test_string_ngrams
    str1 = "one two three four five"
    expected_for_2 = ["one two", "two three", "three four", "four five"]
    expected_for_3 = ["one two three", "two three four", "three four five"]
    assert_equal(expected_for_2, str1.ngrams(2))
    assert_equal(expected_for_3, str1.ngrams(3))
  end
end