require 'spec_helper'

describe Errawr::Error do
  it 'should return a key of :unknown if no key is set' do
    error = Errawr::Error.new
    expect(error.key).to eq(:unknown)
  end

  it 'should return a localized message' do
    error = Errawr::Error.new(:some_error)
    expect(error.message).to eq('Some error has occurred')
  end

  it 'should return a localized message if I18n value is a hash' do
    error = Errawr::Error.new(:error_hash)
    expect(error.message).to eq('Some hashed error has occurred')
  end

  it 'should return an unknown error if error => message is not provided' do
    error = Errawr::Error.new(:bad_error_hash)
    expect(error.message).to eq('An unknown error has occurred')
  end
end
