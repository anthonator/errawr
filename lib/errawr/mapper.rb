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
      base_klass = options[:error] ? options[:error][:base_class] || Error : Error
      raise(ArgumentError, ':base_class must be a subclass of Errawr::Error') unless base_klass <= Error
      klass = Class.new(base_klass).new
      klass.key = key
      klass.context.merge!(options.select { |k, v| ![:error].include?(k) })
      add(klass)
    end
    
    register!(:unknown)
  end
end