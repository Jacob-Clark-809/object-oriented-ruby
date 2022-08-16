class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

hello = Hello.new
hello.hi # Will display "Hello" to console

hello = Hello.new
hello.bye # Will generate a NoMethod error

hello = Hello.new
hello.greet # Will generate an Argument error

hello = Hello.new
hello.greet("Goodbye") # Will display "Goodbye" to console

Hello.hi # Will display a NoMethod error