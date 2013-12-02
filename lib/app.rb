require './artist.rb'
require './song.rb'
require './genre.rb'
require './parser.rb'
require 'debugger'

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
		puts "'library'	=> to view all songs"
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
		exit if @selection == "end"
		library_page if @selection == "library"
		all_artists if @selection == "artist"
		all_genres if @selection == "genre"
		options if @selection == "help"
		
	end


	### OUTPUT PAGES ###

	def all_artists
		divider_fat
		puts "ARTISTS"
		divider_thin
		Artist.all.each do |artist|
			artist.songs.count > 1? s="songs" : s="song"
			puts "#{artist.name} - #{artist.songs.count} #{s}"
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
			genre.songs.count > 1? s="songs" : s="song"
			genre.artists.count > 1? a="artists" : a="artists"
			puts "#{genre.name}: #{genre.songs.count} #{s}, #{genre.artists.count} #{a}"
		end
		divider_thin
		puts "Please select a genre from the list above."
		input
	end

	def artist_page
		artist = Artist.detect(@selection)
		divider_fat
		artist.songs.count > 1? s="songs" : s="song"
		puts "#{artist.name} - #{artist.songs.count} #{s}"
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

	def library_page
		divider_fat
		Song.all.each_with_index do |song, index|
			puts "#{index + 1}. #{song.name} - #{song.artist.name} (#{song.genre.name})"
		end
		input
	end		

	def exit
		puts "Goodbye!"
	end

end

app = PlaylistApp.new


# TO DO:
# genres should be listed in order of most songs first
# make case insensitive
# write new tests
# refactor parser and app
# module
# play song when selected