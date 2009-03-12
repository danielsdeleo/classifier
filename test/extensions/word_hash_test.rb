require File.dirname(__FILE__) + '/../test_helper'
class StringExtensionsTest < Test::Unit::TestCase
	def test_word_hash
		hash = {:good=>1, :"!"=>1, :hope=>1, :"'"=>1, :"."=>1, :love=>1, :word=>1, :them=>1, :test=>1}
		assert_equal hash, "here are some good words of test's. I hope you love them!".word_hash
	end

   	
	def test_clean_word_hash
	   hash = {:good=>1, :word=>1, :hope=>1, :love=>1, :them=>1, :test=>1}
	   assert_equal hash, "here are some good words of test's. I hope you love them!".clean_word_hash
	end
	
	def test_split_more
	  str = "/admin/includes/header.php?Something=1&Another=1&YetAnother[More]=../../Evil/Thing%00"
	  expected = ["adminincludesheaderphpSomething1Another1YetAnotherMoreEvilThing00","/","/","/",
      ".","?","=","&","=","&","[","]=../../","/","%"]
	  assert_equal(expected, str.split_more)
	end
	
	def test_uri_split
	  uri = "/get/a_life//malware/chodes.php?blah=1&blahblah[blech]=../../etc/passwd%00"
	  expected = ["get", "a_life", "malware", "chodes.php", "blah", "1", "blahblah",
	    "blech", "..", "..", "etc", "passwd", "\000" ]
	  assert_equal(expected, uri.uri_split)
	end

end
