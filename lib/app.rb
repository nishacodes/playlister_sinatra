require './artist.rb'
require './song.rb'
require './genre.rb'
require './parser.rb'
# require 'awesome_print'

class PlaylistApp
	def initialize
		Parser.new.run
		@selection
		welcome
	end

	def welcome
		divider_fat
		puts "WELCOME TO MY AWESOME PLAYLIST."
		options
	end	

	def options
		puts "'artist'	=> to view all artists"
		puts "'genre'		=> to view all genres"
		puts "<artist name> 	=> to view songs by an artist"
		puts "<genre name> 	=> to view songs in a genre"
		puts "<song name> 	=> to view song details"
		puts "'help'		=> to see all options"
		puts "'end'		=> to exit the program"
		divider_fat
		puts "Please choose an option from above:"
		input
	end

	def divider_fat
		puts "*" * 50
	end

	def divider_thin
		puts "-" * 50
	end

	def input
		@selection = gets.chomp
		evaluate_selection
	end
	
	def evaluate_selection
		artist_page if Artist.detect(@selection)
		genre_page if Genre.detect(@selection)
		song_page if Song.detect(@selection)	
		all_artists if @selection == "artist"
		all_genres if @selection == "genre"
		options if @selection == "help"
		exit if @selection == "end"
	end

	### OUTPUT PAGES ###

	def all_artists
		divider_fat
		puts "ARTISTS"
		divider_thin
		Artist.all.each do |artist|
			puts "#{artist.name} - #{artist.songs.count} song"
		end
		divider_thin
		puts "Please select an artist from the list above."
		input
	end

	def all_genres
		divider_fat
		puts "GENRES"
		divider_thin
		Genre.all.each do |genre|
			puts "#{genre.name}: #{genre.songs.count} songs, #{genre.artists.count} artists"
		end
		divider_thin
		puts "Please select a genre from the list above."
		input
	end

	def artist_page
		artist = Artist.detect(@selection)
		divider_fat
		puts "#{artist.name} - #{artist.songs.count} songs"
		divider_thin
		artist.songs.each_with_index do |song, index|
			puts "#{index + 1}. #{song.name} - #{song.genre.name}"
		end
		input
	end

	# list name of songs and artists, and total unique artists/songs
	def genre_page
		genre = Genre.detect(@selection)
		divider_fat
		puts "Genre: #{genre.name}"
		divider_thin
		genre.songs.each_with_index do |song, index|
			puts "#{index + 1}. #{song.artist.name} - #{song.name}"
		end
		input
	end
	# should list all the available information on the song, it's artist and genre.
	def song_page
		song = Song.detect(@selection)
		divider_fat
		puts "#{song.name} - #{song.artist.name} (#{song.genre.name})"
		input
	end		

	def exit
		puts "Goodbye!"
	end

end

app = PlaylistApp.new


# TO DO:
# remove .DS_store
# make tests pass again
# genres should be listed in order of most songs first
# remove the extra two songs at the beginning? 
# figure out why it says "goodbye" multiple times when end is selected
# fix singular / plural of song(s) depending on how many are listed
# make case insensitive
# write new tests
# refactor parser and app
# module
# play song when selected
