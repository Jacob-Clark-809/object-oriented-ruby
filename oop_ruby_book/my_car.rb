module Loadable
  def store(object)
    puts "#{object} has been added to the trunk!"
  end
end

class Vehicle
  attr_accessor :speed
  attr_reader :year

  @@number_of_vehicles = 0

  def self.gas_mileage(miles, gallons)
    miles / gallons
  end

  def self.how_many
    @@number_of_vehicles
  end

  def initialize(year)
    @year = year
    @speed = 0
    @@number_of_vehicles += 1
  end

  def speed_up(change)
    self.speed += change
  end

  def brake(change)
    self.speed -= change
  end

  def shut_off
    self.speed = 0
  end

  def age
    puts "This vehile is #{calculate_age} years old"
  end

  private

  def calculate_age
    Time.now.year - self.year
  end

end

class MyCar < Vehicle
  attr_accessor :colour
  attr_reader :model

  NUMBER_OF_DOORS = 4

  def initialize(year, colour, model)
    super(year)
    @colour = colour
    @model = model
  end

  def spray_paint(new_colour)
    self.colour = new_colour
  end

  def to_s
    "#{colour} #{model} made in #{year} and travelling at #{speed} mph."
  end
end

class MyTruck < Vehicle
  include Loadable

  NUMBER_OF_DOORS = 2
end

fred = MyCar.new(2014, "White", "Ford")
fred.speed_up(30)

puts fred

jeff = MyTruck.new(2001)
jeff.store("Golf clubs")

puts Vehicle.how_many

puts "MyCar lookup:"
p MyCar.ancestors
puts "MyTruck lookup:"
p MyTruck.ancestors

jeff.age