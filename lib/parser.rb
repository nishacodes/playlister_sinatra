require './artist.rb'
require './song.rb'
require './genre.rb'
require 'debugger'

class Parser
	attr_accessor :song_list

	def initialize
		@song_list = Dir.new("../data")
		@song_list_delimit
		@artists = []
	end

	def run
		delimit
		# artist_list
		create_objects
		# clean_up
	end

	def delimit
		@song_list_delimit = @song_list.map do |song|
			song.split(/\s-\s|\s\[|\].mp3/)
		end 
		# @song_list_delimit.each do |songarray|
		# 	songarray.delete_at(3) # deletes mp3 item
		# end
	end

	# need to use this list somehow to remove duplicates from Artist.all, but need to name objects
	# def artist_list
	# 	@song_list_delimit.each do |songarray|
	# 		@artists << songarray[0]
	# 		@artists.uniq!
	# 	end
	# end

	# instantiates all objects relative to each other
	def create_objects
		# songarray looks like this [artist, song, genre]
		@song_list_delimit.each do |songarray|
			Artist.find_or_create(songarray[0]).tap do |a|

				
				song = Song.new.tap do |s|
					s.name = songarray[1]
					
					genre = Genre.find_or_create(songarray[2]).tap do |g|
					# genre = Genre.new.tap do |g|
						# g.name = songarray[2]
						g.artists
					end

					s.genre = genre
				end

				a.add_song(song)
				a.genres
			end
		end
	end

	# def clean_up
	# 	Artist.all.uniq!
	# end
end

# parser = Parser.new.run

# # LIST OUT ALL OBJECT NAMES
# Artist.all.each do |artist|
# 	puts artist.name
# 		puts artist.genres
# 	artist.songs.each do |song|
# 		puts song.name
# 		puts song.genre.name
# 	end
# end







