module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!" # In this line self.class will return the class of the calling object
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end