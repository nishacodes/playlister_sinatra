require 'bundler'
Bundler.require
require './lib/artist.rb'
require './lib/genre.rb'
require './lib/parser.rb'
require './lib/song.rb'



module Playlister
  class App < Sinatra::Application
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

  end

  class Parser
    attr_accessor :song_list, :song_list_delimit

    def initialize
      @song_list = Dir.entries("../data").select {|f| !File.directory? f}
      @song_list_delimit
      delimit
      create_objects
    end

    def delimit
      @song_list_delimit = @song_list.map do |song|
        song.split(/\s-\s|\s\[|\].mp3/)
      end 
    end

    def create_objects
      # songarray looks like this [artist, song, genre]
      @song_list_delimit.each do |songarray|
        Artist.find_or_create(songarray[0]).tap do |a|
          song = Song.new.tap do |s|
            s.name = songarray[1]
            genre = Genre.find_or_create(songarray[2]).tap do |g|
              g.artists
            end
            s.genre = genre
        end
          a.add_song(song)
          a.genres
        end
      end
    end
  end
end