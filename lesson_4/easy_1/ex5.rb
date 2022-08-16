class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

# Only the Pizza class above has an instance variable because it is declared with
# an @ preceding the name.