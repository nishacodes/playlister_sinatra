require './artist.rb'
require './song.rb'
require './genre.rb'
require './parser.rb'

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
				puts "*" * 60
				puts "Please select an artist from the list above."
				@myartist = gets.chomp
			when "genre"
				Genre.all.each do |genre|
					puts "#{genre.name} - #{genre.artists.count} artist"
				end
				puts "*" * 60
				puts "Please select a genre from the list above."
				@mygenre = gets.chomp
		end
			
	end
end

app = PlaylistApp.new
app.run