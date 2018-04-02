require 'json'
require 'open-uri'

class GamesController < ApplicationController

  RESULTS = {
    1 => {text: "Sorry but cant be built"},
    2 => {text: "Sorry but its not and English word"},
    3 => {text: "Congratulations!"}
  }
  def new
    @letters = [*('A'..'Z')].sample(10)
  end

  def vocabulary
    url = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{(params[:word]).to_s}").read)
    url["found"]
  end

  def compare
    word_array = params[:word].split.sort
    word_array.each_with_index do |item, i|
      if params[:letters].split.sort.include? (item)
        word_array.delete_at[i]
      else
        word_array
      end
    end
    word_array.empty?
  end

  def score
    if compare == false
      @result = RESULTS[1][:text]
    elsif vocabulary == false
      @result = RESULTS[2][:text]
    else
      @result = RESULTS[3][:text]
    end
  end
end
