require 'spec_helper'

describe Errawr::Error do
  it 'should return a key of :unknown if no key is set' do
    error = Errawr::Error.new
    error.key.should == :unknown
  end
  
  it 'should return the key as name if name is not set' do
    error = Errawr::Error.new
    error.key = :some_key
    error.name.should == :some_key
  end
  
  it 'should return name if name is set' do
    error = Errawr::Error.new
    error.name = :some_name
    error.name.should == :some_name
  end
  
  it 'should return a localized message' do
    I18n.load_path += Dir.glob('spec/support/en.yml')
    error = Errawr::Error.new
    error.key = :some_error
    error.message.should == 'Some error has occurred'
  end
end