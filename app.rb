require 'bundler'
Bundler.require
require './lib/artist.rb'
require './lib/genre.rb'
require './lib/song.rb'
require './lib/parser.rb'
require 'youtube_it'
require './lib/scraper.rb'


module Playlister
  class App < Sinatra::Application
    
    
    Parser.new
    

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
      @category = "artist"
      @artist_name = params[:name].gsub('_',' ')
      @title = @artist_name
      @current_artist = Artist.detect(@artist_name)
      erb :artist_detail
    end

    get '/genre/:name' do
      @category = "genre"
      @genre_name = params[:name]
      @title = @genre_name
      @current_genre = Genre.detect(@genre_name)
      erb :genre_detail
    end
    
    get '/:category/:name/:song' do
      @song_name = params[:song].gsub('_',' ')
      @current_song = Song.detect(@song_name)
      # scrape youtube video below
      my_scraper = Video_Scraper.new(@current_song.artist.url_format, @current_song.url_format)
      url = my_scraper.video # scraped url from youtube API
      match_obj = /.*v\/(.*)\?.*/.match(url)
      @video = match_obj[1]
      # load the same page user is currently on below
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