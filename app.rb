require 'bundler'
Bundler.require
require './lib/artist.rb'
require './lib/genre.rb'
require './lib/song.rb'
require './lib/parser.rb'
require './lib/scraper.rb'
# require 'youtube_it'

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
      @title = @genre_name.capitalize
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
          params.inspect
          erb :artist_detail
        when "song"
          erb :song
        end
    end

    post '/search' do
      @criteria = params["search"]
      @title = "Search Results for '#{@criteria}'"
      search(@criteria)
      erb :search_results
    end

    helpers do 
      def simple_partial(template)
        erb template
      end

      def search(word)
        @song_results = []
        @artist_results = []
        @genre_results = []
        word.downcase!
        Song.all.each do |song|
         @song_results << song if song.name.downcase.include?(word)
         @song_results << song if song.artist.name.downcase.include?(word)
         @song_results << song if song.genre.name.downcase.include?(word)
        end
        Artist.all.each do |artist|
         @artist_results << artist if artist.name.downcase.include?(word)
        end
        Genre.all.each do |genre|
         @genre_results << genre if genre.name.downcase.include?(word)
        end
      end
    end

  end
end


# TO DO
# deploy on heroku
# fix the song list page (song links not working)
# incorporate spotify?
# add play buttons
# format songlists
# jquery drag and drop to playlist
# autoplay the next song on the playlist
# use javascript to keep the video partial always there and playing, even when user is clicking around
