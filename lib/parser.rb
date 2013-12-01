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

	def delimit
		@song_list_delimit = @song_list.map do |song|
			song.split(/\s-\s|\[|\]/)
		end 
		@song_list_delimit.each do |songarray|
			songarray.delete_at(3) # deletes mp3 item
		end
	end


end


parser = Parser.new.delimit