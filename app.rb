require 'bundler'
Bundler.require
require './lib/artist.rb'
require './lib/genre.rb'
require './lib/song.rb'
require './lib/parser.rb'
# require './lib/scraper.rb'


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
      @artist_name = params[:name].gsub('_',' ')
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
    
    get '/:category/:name/:song' do
      @song_name = params[:song].gsub('_',' ')
      @current_song = Song.detect(@song_name)
      @current_song.add_video_id("rYEDA3JcQqw")
      case params[:category]
        when "genre"
          @genre_name = params[:name]
          @title = @genre_name
          @current_genre = Genre.detect(@genre_name)
          erb :genre_detail
        when "artist"
          @artist_name = params[:name].gsub('_',' ')
          @title = @artist_name
          @current_artist= Artist.detect(@artist_name)
          erb :artist_detail
        when "song"
          @stub = params[:name]
          erb :song
        end
    end


    helpers do 
      def simple_partial(template)
        erb template
      end
    end

  end
end