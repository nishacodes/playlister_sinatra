# require 'song'
# require 'genre'

class Artist
	attr_accessor :name, :songs, :genres

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
    # song.genre.artists << self
  end
  
  # count the songs in the array
  def songs_count
    songs.count
  end

  # for every song in the array, get the genre from the Song class, genre method
  def genres
    songs.collect {|song| song.genre}.uniq

  end

  # CLASS METHODS
  def self.all
    @@all
  end

  def self.count
  	@@all.count
  end

	def self.reset_artists
		@@all.clear
	end
end


# artist = Artist.new
# artist2 = Artist.new

# # artist.add_song(song1)
# # puts artist.genre

# puts Artist.all
# puts Artist.count

# Artist.reset_artists
# puts Artist.count





