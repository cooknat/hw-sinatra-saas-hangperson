class HangpersonGame
 attr_accessor :word, :guesses, :wrong_guesses
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

 
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(char)
    raise ArgumentError unless char =~ /[[:alpha:]]/ 
      if @word.include?(char.downcase) && !@guesses.include?(char.downcase) 
        @guesses = "#{@guesses}#{char}"
      elsif !@word.include?(char.downcase) && !@wrong_guesses.include?(char.downcase) 
        @wrong_guesses += "#{@wrong_guesses}#{char}"
      else
        return false  
      end         
    return true 
  end  

  def word_with_guesses
    str = ''
    @word.each_char do |ch|
      if @guesses.include?(ch)
        str += ch
      else  
        str += '-'
      end
    end 
    str
  end  

  def check_win_or_lose
    num_guesses = @guesses.length + @wrong_guesses.length
    if word_with_guesses == @word
      return :win
    elsif num_guesses > 7
      return :lose
    else
      return :play
    end  
  end  

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
