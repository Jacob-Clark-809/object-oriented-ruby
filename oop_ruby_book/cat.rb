module Scratch
  def scratch
    puts "Scritchy Scratchy"
  end
end

class Cat
  include Scratch
end

frank = Cat.new
frank.scratch
