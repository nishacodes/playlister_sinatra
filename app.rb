require 'bundler'
Bundler.require
require './lib/artist.rb'
require './lib/genre.rb'
require './lib/song.rb'
require './lib/parser.rb'


module Playlister
  class App < Sinatra::Application
    
    before do 
      Parser.new
    end

    get '/' do
      erb :index
    end

    get '/:category' do
      @category = params[:category]
      if @category == "artist"
        erb :artist
      elsif @category == "genre"
        erb :genre
      else @category == "song"
        erb :song
      end
    end

    get '/genre/:name' do
      @genre_name = params[:name]
      @current_genre = Genre.detect(@genre_name)
      erb :genre_detail
    end


  end
end