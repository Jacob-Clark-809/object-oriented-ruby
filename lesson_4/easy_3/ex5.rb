class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new
tv.manufacturer # NoMethod error
tv.model # Works fine

Television.manufacturer # Works fine
Television.model # NoMethod error