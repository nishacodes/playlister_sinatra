class Genre
	attr_accessor :name, :songs, :artists

	@@all = []
	def initialize
		@name
		@songs = []
		@artists = []
		@@all << self if @@all.include?(self) == false
	end

	def artists
		songs.collect{|song| song.artist}.uniq
	end

	# CLASS METHODS
	def self.all
		@@all
	end

	 def self.count
  	@@all.count
  end

	def self.reset_genres
		@@all.clear
	end


end

# rap = Genre.new
# rap.name="rap"
# puts rap.songs

# puts Genre.all
# puts 