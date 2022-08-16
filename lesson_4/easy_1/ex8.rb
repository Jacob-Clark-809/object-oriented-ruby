class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1 # The self on this line will refer to the calling object, i.e. the instance of the class calling this method.
  end
end