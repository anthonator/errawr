require 'i18n'

require 'errawr/error'
require 'errawr/mapper'
require 'errawr/version'

module Errawr
  I18n.load_path << "#{File.dirname(__FILE__)}/errawr/locales/en.yml"
  I18n.reload!

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def error!(name, context = {})
      klass = Mapper[name] || Error.new(name, context)
      klass.update_context(context) unless context.empty?
      fail klass
    end

    def register!(key, options = {})
      Mapper.register!(key, options)
    end
  end

  extend ClassMethods

  register!(:unknown)
end
