module Errawr
  class Error < StandardError
    attr_reader :key, :context, :message
    
    def initialize(key = :unknown, context = {})
      @key = key
      @i18n = I18n.t('errawr.' + @key.to_s)
      process_context(context)
      process_message
    end
    
    private
    def process_context(context)
      if @i18n.kind_of?(Hash)
        @context = @i18n.merge(context)
        @context.delete(:error)
      else
        @context = {}
      end
    end
    
    def process_message
      if @i18n.kind_of?(Hash)
        key = 'errawr.' + @key.to_s + '.error.message'
        @message = I18n.t(key, @context, { default: I18n.t('errawr.unknown', @context) })
      else
        @message = I18n.t('errawr.' + @key.to_s, @context)
      end
    end
  end
end