class Book
	attr_accessor :name, :real_price
	
	def initialize(pl, per)
		@name = pl
		@real_price = per
	end
	
	def to_s
	  "Book called: #{@name}"
	end
	
	def price
		self.real_price + 10
	end
	
	protected :real_price
end

bones = Book.new("echoes bones", 15)
puts bones
puts bones.price 
puts bones.real_price