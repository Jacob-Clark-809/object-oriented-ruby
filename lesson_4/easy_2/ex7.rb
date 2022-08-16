class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# The @@cats_count above is a class variable that counts the number of instances of
# the Cat class that have been created in your code.

frank = Cat.new("tabby")
tom = Cat.new("tabby")
felix = Cat.new("brown")

puts Cat.cats_count