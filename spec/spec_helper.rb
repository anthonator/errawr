require 'coveralls'
Coveralls.wear!

require 'errawr'

# Require supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| puts f; require f }

RSpec.configure do |config|
  config.before(:each) do
    I18n.load_path += Dir.glob('spec/support/en.yml')
    I18n.reload!
  end
end