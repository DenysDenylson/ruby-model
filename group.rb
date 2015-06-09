class Group
	attr_accessor :vertex_list
	attr_accessor :normal_list
	attr_accessor :texture_vertex_list
	attr_accessor :index_list
	attr_accessor :size

	def initialize(group, object)
		triangles = group.triangles
		
		@vertex_list = []
		@texture_vertex_list = []
		@index_list = []
		@normal_list = []

		i = 0
		triangles.each do |triangle|
			load_vertex(object, triangle, i, 0)
			@index_list << i
    		i +=  1
    		load_vertex(object, triangle, i, 1)
			@index_list << i
    		i +=  1
    		load_vertex(object, triangle, i, 2)
			@index_list << i
    		i +=  1
		end
		@size = @index_list.size
		@vertex_list = @vertex_list.pack("f*")
		@index_list = @index_list.pack("I*")
	end

	def draw
		glEnableClientState(GL_VERTEX_ARRAY)
		
		glVertexPointer(3, GL_FLOAT, 0, @vertex_list)

		glDrawElements(GL_TRIANGLES, @size, GL_UNSIGNED_INT, @index_list)

		glDisableClientState(GL_VERTEX_ARRAY)
	end

	private
	def load_vertex(object, triangle, i, vertex)
		index = triangle.vertices[vertex].position_index
		v = object.vertices[index - 1]
		@vertex_list[3 * i] = v.x
		@vertex_list[3 * i + 1] = v.y
		@vertex_list[3 * i + 2] = v.z
	end
end