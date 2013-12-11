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
      # partial
    end

    get '/' do
      erb :index
    end

    get '/:category' do
      @category = params[:category]
      if @category == "artist"
        @title = "Artists"
        erb :artist
      elsif @category == "genre"
        @title = "Genres"
        erb :genre
      else @category == "song"
        @title = "Songs"
        erb :song
      end
    end

    get '/artist/:name' do
      @artist_name = params[:name]
      @title = @artist_name
      @current_artist= Artist.detect(@artist_name)
      erb :artist_detail
    end

    get '/genre/:name' do
      @genre_name = params[:name]
      @title = @genre_name
      @current_genre = Genre.detect(@genre_name)
      erb :genre_detail
    end

    # get '/song/:name' do
    #   @song_name = params[:name]
    #   @current_genre = Genre.detect(@genre_name)
    #   erb :genre_detail
    # end

    helpers do 
      def simple_partial(template)
        erb template
      end
    end

  end
end