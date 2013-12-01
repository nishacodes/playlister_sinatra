require './artist.rb'
require './song.rb'
require './genre.rb'


song_list = Dir.new("../data")

song_list.entries.each do |song|
	song.split("-")
	puts song
end