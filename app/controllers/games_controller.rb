require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def is_grid
    @answer.chars.sort.all? { |letter| @grid.include?(letter) }
  end

  def valid_english_word
    url = "https://dictionary.lewagon.com/#{@answer}"
    JSON.parse(URI.open(url).read)
  end

  def score
    @grid = params[:grid]
    @answer = params[:word]
    if !is_grid
      @result = "Sorry, but #{@answer.upcase} can't be built out of #{@grid}"
    elsif !valid_english_word
      @result = "SORRY, but #{@answer.upcase} does not seem to be an english word"
    else
      @result = "Congratulations!, #{@answer.upcase} is a valid English word!"
    end
  end
end
