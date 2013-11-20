require 'i18n'

require 'errawr/error'
require 'errawr/mapper'
require 'errawr/version'

module Errawr
  I18n.load_path += Dir.glob('lib/errawr/locales/*.{rb,yml}')
  I18n.reload!
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def error!(name, context = {})
      klass = Mapper[name] || Mapper[:unknown]
      klass.metadata.merge!(context.delete(:metadata) || {})
      klass.context.merge!(context)
      raise klass
    end

    def register!(key, options = {})
      Mapper.register!(key, options)
    end
  end
  extend ClassMethods
end
