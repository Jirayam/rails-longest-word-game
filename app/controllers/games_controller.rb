# we have to require open-uri because it is not in ROR
require 'open-uri'

# this is a comment for rubocop
class GamesController < ApplicationController
  def new
    @letters = []
    9.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    if word_in_dictionnary? && word_is_valid?
      @message = "Congratulation #{@word} is a valid english word"
    elsif word_in_dictionnary?
      @message = "Sorry but #{@word} can't be built with letters: #{@letters}"
    elsif word_is_valid?
      @message = 'Sorry the letters are ok but it is not a valid english word'
    end
  end

  private

  def word_in_dictionnary?
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_in_dictionnary = JSON.parse(open(url).read)
    word_in_dictionnary['found']
  end

  def word_is_valid?
    check_letters = []
    all_letters = @word.upcase.split('')
    all_letters.each do |letter|
      check_letters << @letters.include?(letter)
    end
    check_letters.all?(true)
  end
end
