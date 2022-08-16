module Writable
  attr_accessor :hello
end

class Student
  include Writable

  attr_accessor :name

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other)
    grade > other.grade
  end

  protected

  attr_reader :grade
end

bob = Student.new("Bob", 25)
steve = Student.new("Steve", 99)

# puts bob.better_grade_than?(steve)

bob.hello = "Yes"
puts bob.hello