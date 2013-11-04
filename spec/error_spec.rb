require 'spec_helper'

describe Errawr::Error do
  it 'should return a key of :unknown if no key is set' do
    error = Errawr::Error.new
    error.key.should == :unknown
  end
  
  it 'should return a localized message' do
    I18n.load_path += Dir.glob('spec/support/en.yml')
    error = Errawr::Error.new
    error.key = :some_error
    error.message.should == 'Some error has occurred'
  end
end