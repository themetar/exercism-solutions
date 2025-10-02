require_relative 'sayer'

class HelloWorld
	def self.hello
		Sayer.new("Hello, World!").say
	end
end
