module Errawr
  class Error < StandardError
    attr_accessor :key, :context
    
    def initialize(msg = nil)
      super(msg)
      @key = :unknown
      @context = {}
    end
    
    def message
      I18n.t('errawr.' + @key.to_s, context)
    end
  end
end