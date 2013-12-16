class Song
	attr_accessor :video_id, :name, :genre, :artist

	@@all = []

	def initialize
		@name
		@artist
		@genre
		@@all << self
	end

	# sets the genre name
	# also adds this song to that genre in the Genre class
	def genre=(genre)
		@genre = genre
		genre.songs << self
	end

  # used for scraper / nokogiri
  def url_format
    self.name.gsub(" ", "%20").gsub(".", "").downcase
  end

	# CLASS METHODS
	def self.all
    @@all
  end

  def self.detect(song_name)
    @@all.detect do |song|
      song.name == song_name
    end
  end

  def self.count
  	@@all.count
  end

  def self.reset_songs
		@@all.clear
	end


end

