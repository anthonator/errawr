require 'spec_helper'

describe Errawr::Error do
  it 'should return a key of :unknown if no key is set' do
    error = Errawr::Error.new
    error.key.should == :unknown
  end
  
  it 'should return a localized message' do
    error = Errawr::Error.new(:some_error)
    error.message.should == 'Some error has occurred'
  end
  
  it 'should return a localized message if I18n value is a hash' do
    error = Errawr::Error.new(:error_hash)
    error.message.should == 'Some hashed error has occurred'
  end
  
  it 'should return an unknown error if error => message is not provided' do
    error = Errawr::Error.new(:bad_error_hash)
    error.message.should == 'An unknown error has occurred'
  end
  
  it 'should insert custom values into the context if I18n value is a hash' do
    error = Errawr::Error.new(:error_hash)
    error.metadata[:name].should == 'error_name'
  end
end