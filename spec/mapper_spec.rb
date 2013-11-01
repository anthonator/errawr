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
      expect { Errawr.register!(:dummy_error, { error: { base_class: StandardError } }) }.to raise_error(ArgumentError)
    end
  
    it 'should override error name if error_name options is passed' do
      Errawr.register!(:dummy_error, { error: { name: :same_dummy_error } })
      Errawr::Mapper[:dummy_error].name.should == :same_dummy_error
    end
    
    it 'should add an error to stored errors' do
      Errawr.register!(:dummy_error)
      Errawr::Mapper[:dummy_error].should_not be_nil
    end
    
    it 'should not add :error options to context' do
      Errawr.register!(:dummy_error, error: { name: :same_dummy_error })
      begin
        Errawr.error!(:dummy_error)
      rescue => e
        e.context.include?(:error).should be_false
      end
    end
  end
end