require 'open-uri'

class GamesController < ApplicationController
  def new
    @vowels = ['A', 'E', 'I', 'O', 'U', 'Y']
    @letters = @vowels.sample(3)
    @letters += ('A'..'Z').to_a.sample(7)
  end

  def score
    answer = params[:answer].upcase
    letters = params[:letters]
    if included_in_grid?(answer, letters) && english_word?(answer)
      @result = "Well done"
    else @result = "Nice try"
    end
  end

  private
  def included_in_grid?(answer, letters)
    answer.chars.all? { |letter| answer.chars.count(letter) <= letters.chars.count(letter) }
  end

  def english_word?(answer)
    response = open("https://wagon-dictionary.herokuapp.com/#{answer}")
    json = JSON.parse(response.read)
    json['found']
  end
end
