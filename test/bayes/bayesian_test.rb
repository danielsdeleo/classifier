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
	 assert_equal(expected, @classifier.token_counts_for(text))
	end
	
	def test_ngram_size_setter
	 @classifier.set_ngram_size(5)
	 assert_equal([5], @classifier.ngram_sizes)
	 @classifier.set_ngram_size(2..4)
	 assert_equal([2,3,4], @classifier.ngram_sizes)
	 @classifier.set_ngram_size([3,5,7])
	 assert_equal([3,5,7], @classifier.ngram_sizes)
	 @classifier.set_ngram_size(1..3)
	 assert_equal([2,3], @classifier.ngram_sizes)
	end
	
	def test_ngram_tokenizing
	  @classifier.tokenize_as :text
	  @classifier.set_ngram_size(2..3)
	  text = "here is some text"
	  expected = {:"is some"=>1, :"some text"=>1, :"here is some"=>1, :"is some text"=>1, :"text"=>1, :"here is"=>1 }
	  assert_equal(expected, @classifier.token_counts_for(text))
	end
end