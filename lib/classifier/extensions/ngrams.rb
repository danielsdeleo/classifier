# Author::    Daniel DeLeo  (mailto:ddeleo@basecommander.net)
# Copyright:: Copyright (c) 2005 Lucas Carlson
# License::   LGPL

class String
  
  # Generates ngrams based on string.
  # for possible C code, see http://homepages.inf.ed.ac.uk/s0450736/ngram.html
  def ngrams(n)
    words = split_more
    ngram_list = []
    if n > 0 && n <= words.count
      (0 .. (words.count - n)).each do |i|
        ngram_list << words[i, n].join(' ')
      end
    end
    return ngram_list
  end
  
end
