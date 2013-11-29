class Song
	attr_accessor :name, :genre, :artist

	@@all = []

	def initialize
		@name
		@artist
		@genre
		@@all << self
	end

	# sets the genre name
	# also adds this song to that genre in the Genre class
	def genre=(new_genre)
		@genre = new_genre
		genre.songs << self
	end

	# CLASS METHODS
	def self.all
    @@all
  end

  def self.count
  	@@all.count
  end

  def self.reset_songs
		@@all.clear
	end
end

# song1 = Song.new("Rolling in the deep")
# song1.genre("folk")
