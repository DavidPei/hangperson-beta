class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(new_word)
  	@word = new_word
  	@guesses = ""
  	@wrong_guesses = ""
  end

  def guess(letter)
  	if (letter == nil) or (letter == "") or ((/[[:alpha:]]/ =~ letter) == nil)
  		raise ArgumentError.new("Invalid guess.")
  	elsif @guesses.include?(letter.downcase) or @wrong_guesses.include?(letter.downcase)
  		return false
  	else
  		#this is a valid letter
 		if @word.downcase.include?(letter)
 			@guesses += letter.downcase
 		else
 			@wrong_guesses += letter.downcase
 		end
 		return true
 	end
  end
  		
  def word_with_guesses
  	result = ""
  	@word.downcase.split("").each do |letter|
  		if @guesses.downcase.include? "#{letter}"
  			result += "#{letter}"
  		else
  			result += "-"
  		end
  	end
  	return result
  end

  def check_win_or_lose
  	limit = 7
  	if word_with_guesses == word
  		return :win
  	elsif wrong_guesses.length >= limit
 		return :lose
 	else
 		return :play
 	end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
