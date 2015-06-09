require 'wavefront'
require_relative 'group'

class Model
	attr_accessor :group_list

	def initialize(file)
		model = Wavefront::File.new file
		@group_list = []
		object = model.object
  		model.object.groups.each do |group|
  			g = Group.new(group, object)
  			@group_list << g
  		end
	end

	def draw
		@group_list.each do |g|
			g.draw
		end
	end
end