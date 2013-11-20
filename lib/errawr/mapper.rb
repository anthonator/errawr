module Errawr
  class Mapper
    @@errors = {}
    
    def self.all
      @@errors.dup
    end
    
    def self.[](key)
      @@errors[key.to_sym]
    end
    
    def self.add(error)
      @@errors[error.key] = error
    end
    
    def self.register!(key, options = {})
      base_klass = options[:base_class] || Error
      raise(ArgumentError, ':base_class must be a subclass of Errawr::Error') unless base_klass <= Error
      klass = Class.new(base_klass).new(key, options)
      add(klass)
    end
  end
end