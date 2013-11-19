require 'spec_helper'

describe Errawr::Mapper do
  it 'should automatically register an unknown error' do
    Errawr::Mapper.all[:unknown].should_not be_nil
  end
  
  describe '[]' do
    it 'should return stored errors' do
      Errawr::Mapper[:unknown].should_not be_nil
    end
  end
  
  describe 'add' do
    it 'should add an error to stored errors' do
      Errawr::Mapper.add(DummyError.new)
      Errawr::Mapper[:dummy_key].should_not be_nil
    end
  end
  
  describe 'register!' do
    it 'should throw an error if base class is not a subclass of Errawr::Error' do
      expect { Errawr.register!(:dummy_error, base_class: StandardError) }.to raise_error(ArgumentError)
    end
    
    it 'should add an error to stored errors' do
      Errawr.register!(:dummy_error)
      Errawr::Mapper[:dummy_error].should_not be_nil
    end
    
    it 'should not add :metadata options to context' do
      Errawr.register!(:dummy_error, metadata: { name: :same_dummy_error })
      begin
        Errawr.error!(:dummy_error)
      rescue => e
        e.metadata.include?(:error).should be_false
      end
    end
  end
end