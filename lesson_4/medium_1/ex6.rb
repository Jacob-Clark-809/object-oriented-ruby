class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end

# The firt class implementation accesses the instance variable @template
# directly in the create_template method whereas the second uses the
# template=() method created by the attr_accessor.
# The implementation for show_template is identical in both cases.