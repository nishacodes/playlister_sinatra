# require 'song'
# require 'genre'
# require 'classmethods'

class Artist
	attr_accessor :name, :songs, :genres
  # extend Memorable
	
  @@all = []
	
	def initialize
		@name
		@songs = []
    @genres = []
		@@all << self
	end

  # add a Song object to the songs array 
  # set the artist of that song to this artist 
  def add_song(song)
  	songs << song
    song.artist = self
  end
  
  # count the songs in the array
  def songs_count
    songs.count
  end

  # for every song in the array, get the genre from the Song class, genre method
  def genres
    songs.collect {|song| song.genre}.uniq
  end

  # used for scraper / nokogiri
  def url_format
    self.name.gsub(" ", "%20").gsub(".", "").downcase
  end
  # CLASS METHODS
  def self.all
    @@all
  end

  def self.detect(artist_name)
    @@all.detect do |artist|
      artist.name == artist_name
    end
  end

  def self.find_or_create(artist_name)
    detect(artist_name) || Artist.new.tap {|a| a.name = artist_name}
  end

  def self.count
  	@@all.count
  end

	def self.reset_all
		@@all.clear
	end
end



