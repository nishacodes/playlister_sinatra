class Song
	attr_accessor :video_id, :name, :genre, :artist

	@@all = []

	def initialize
		@name
		@artist
		@genre
		@@all << self
    @video_id = add_video_id
	end

	# sets the genre name
	# also adds this song to that genre in the Genre class
	def genre=(genre)
		@genre = genre
		genre.songs << self
	end
  
  def add_video_id
    client = YouTubeIt::Client.new
    searchdata = client.videos_by(:query => "#{@artist} - #{@name}", :page => 1, :per_page => 1)
    songdata = searchdata.videos
    videodata = songdata[0]
    video_id_long = videodata.video_id
    video_object = video_id_long.match(/video:(.*)/)
    video_object[1]
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

