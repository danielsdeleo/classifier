require File.dirname(__FILE__) + '/../test_helper'
class BayesianTest < Test::Unit::TestCase
	def setup
		@classifier = Classifier::Bayes.new 'Interesting', 'Uninteresting'
	end
	
	def test_good_training
		assert_nothing_raised { @classifier.train_interesting "love" }
	end

	def test_bad_training
		assert_raise(StandardError) { @classifier.train_no_category "words" }
	end
	
	def test_bad_method
		assert_raise(NoMethodError) { @classifier.forget_everything_you_know "" }
	end
	
	def test_categories
		assert_equal ['Interesting', 'Uninteresting'].sort, @classifier.categories.sort
	end

	def test_add_category
		@classifier.add_category 'Test'
		assert_equal ['Test', 'Interesting', 'Uninteresting'].sort, @classifier.categories.sort
	end

	def test_classification
		@classifier.train_interesting "here are some good words. I hope you love them"
		@classifier.train_uninteresting "here are some bad words, I hate you"
		assert_equal 'Uninteresting', @classifier.classify("I hate bad words and you")
	end
	
	def test_tokenizer_type_defaults_to_text
	 assert_equal(:text, @classifier.tokenizer_type)
	end
	
	def test_tokens_for_when_type_is_uri_text
	 text = "one/two?three/four&five"
	 expected = {"one" => 1, "two" => 1, "three" => 1, "four" => 1, "five" => 1}
	 @classifier.tokenize_as :uri
	 assert_equal(expected, @classifier.tokens_for(text))
	end
end