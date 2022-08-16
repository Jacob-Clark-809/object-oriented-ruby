class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    @first_name, @last_name = name.split(' ')
    @last_name = '' if @last_name == nil
  end

  def name
    (self.first_name + ' ' + self.last_name).strip
  end

  def name=(name)
    names = name.split(' ')
    self.first_name = names[0]
    self.last_name = names[1] if names.size > 1
  end

  def to_s
    name
  end
end

bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

p bob.name == rob.name

p "The person's name is #{bob}"