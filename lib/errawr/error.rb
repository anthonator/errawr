module Errawr
  class Error < StandardError
    attr_accessor :key, :context
    
    attr_writer :name
    
    def initialize(msg = nil)
      super(msg)
      @key = :unknown
      @context = {}
    end
    
    def name
      @name || @key
    end
    
    def message
      I18n.t('errawr.' + @key.to_s, context)
    end
  end
end