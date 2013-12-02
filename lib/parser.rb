require './artist.rb'
require './song.rb'
require './genre.rb'
require 'debugger'

class Parser
	attr_accessor :song_list

	def initialize
		@song_list = Dir.new("../data")
		@song_list_delimit
	end

	def run
		delimit
		create_objects
		add_relationships
	end

	def delimit
		@song_list_delimit = @song_list.map do |song|
			song.split(/\s-\s|\[|\]/)
		end 
		@song_list_delimit.each do |songarray|
			songarray.delete_at(3) # deletes mp3 item
		end
	end


	def create_objects
		@song_list_delimit.each do |songarray|
			Artist.new.tap do |artist|
				artist.name = songarray[0]
				song = Song.new.tap do |s|
					s.name = songarray[1]
					genre = Genre.new.tap do |g|
						g.name = songarray[2]
					end
					s.genre = genre
				end
				artist.add_song(song)
			end
		end

		Artist.all.each do |artist|
			puts artist.name
			artist.songs.each do |song|
				puts song.name
				puts song.genre.name
			end
		end
		# Song.all.each do |song|
		# 	puts song.name
		# 	puts song.genre.name
		# end
	end

	def add_relationships
		Artist.all.each do |artist|
			@song_list_delimit.each do |songarray|
				if artist == songarray[0]
					artist.add_song("songarray[1]")
				end
			end
		end
	end

end

parser = Parser.new.run