require './artist.rb'
require './song.rb'
require './genre.rb'
require './parser.rb'
require 'awesome_print'

class PlaylistApp
	def initialize
		@selection
		@myartist
		@mygenre
	end

	def run
		Parser.new.run
		welcome
	end

	def divider
		puts "*" * 60
	end
	
	def welcome
		puts "Welcome to my playlist."
		puts "Do you want to browse by artist or genre?"
		@selection = gets.chomp
		show_list
	end	

	def show_list
		case @selection
			when "artist"
				Artist.all.each do |artist|
					puts "#{artist.name} - #{artist.songs.count} song"
				end
				divider
				puts "Please select an artist from the list above."
				@myartist = gets.chomp
				artistSelect
			when "genre"
				Genre.all.each do |genre|
					puts "#{genre.name}: #{genre.songs.count} songs, #{genre.artists.count} artists"
				end
				divider
				puts "Please select a genre from the list above."
				@mygenre = gets.chomp
				genreSelect
		end
	end

	def artistSelect
		Artist.all.each do |artist|
			if artist.name == @myartist
				divider
				puts "#{artist.name.upcase} - #{artist.songs.count} songs"
				artist.songs.each_with_index do |song, index|
					puts "#{index + 1}. #{song.name}- #{song.genre.name}"
				end
			end
		end
	end

	def genreSelect
		puts "you chose #{@mygenre}"
	end
			
end

app = PlaylistApp.new
app.run

# TO DO:
# genres should be listed in order of most songs first
# genres not counting songs/artists correctly
# remove the extra two songs at the beginning? 
# display all types of pages
# clean up parser 
# clean up app
# module
# play song when selected