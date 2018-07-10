module CXMap
  # Default way to set up CXMap in initializer with all configuration values.
  def self.setup
    yield self
  end
end
