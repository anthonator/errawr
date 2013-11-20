module Errawr
  class Error < StandardError
    attr_reader :key, :context, :metadata
    
    def initialize(key = :unknown, context = {})
      @key = key
      @i18n = I18n.t('errawr.' + @key.to_s)
      process_context(context)
      process_metadata(context)
      process_message
    end
    
    def message
      @context[:message]
    end
    
    private
    def process_context(context)
      if @i18n.kind_of?(Hash)
        @context = @i18n.merge(context)
        @context.delete(:metadata)
        @message_overridden = context.include?(:message)
      else
        @context = context
      end
    end
    
    def process_metadata(context)
      if @i18n.kind_of?(Hash)
        context = @i18n.merge(context)
      end
      @metadata = context.fetch(:metadata, {})
    end
    
    def process_message
      if @i18n.kind_of?(Hash)
        if @message_overridden
          @context[:message]
        else
          key = 'errawr.' + @key.to_s + '.message'
          @context[:message] = I18n.t(key, @context.merge({ default: I18n.t('errawr.unknown', @context) }))
        end
      else
        @context[:message] = I18n.t('errawr.' + @key.to_s, @context) unless @context[:message]
      end
    end
  end
end