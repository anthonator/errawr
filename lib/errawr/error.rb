module Errawr
  class Error < StandardError
    attr_reader :key, :context, :metadata
    
    def initialize(key = :unknown, context = {})
      @key = key
      @context = context
      @metadata = {}
      @i18n = I18n.t('errawr.' + @key.to_s)
      update_context(@context)
    end
    
    def message
      process_message
    end
    
    def update_context(context)
      process_context(context)
    end
    
    private
    def process_context(context)
      @message_overridden = context.include?(:message)
      if @i18n.kind_of?(Hash)
        @context.merge!(@i18n.merge(context))
      else
        @context.merge!(context)
      end
      @metadata.merge!(@context.delete(:metadata)) if @context.has_key?(:metadata)
    end
    
    def process_message
      return @context[:message] if @message_overridden
      if @i18n.kind_of?(Hash)
        key = 'errawr.' + @key.to_s + '.message'
        @context[:message] = I18n.t(key, @context.merge({ default: I18n.t('errawr.unknown', @context) }))
      else
        @context[:message] = I18n.t('errawr.' + @key.to_s, @context) unless @context[:message]
      end
      @context[:message]
    end
  end
end