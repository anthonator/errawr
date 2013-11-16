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
  
  describe 'error!' do
    it 'should return custom context values from locale file' do
      Errawr.register!(:error_hash)
      begin
        Errawr.error!(:error_hash)
      rescue => e
        e.context.include?(:name).should be_true
      end
    end
    
    it '#register! should override custom context values from locale file' do
      Errawr.register!(:error_hash, name: 'register!_name')
      begin
        Errawr.error!(:error_hash)
      rescue => e
        e.context[:name].should == 'register!_name'
      end
    end
    
    it '#error! should override custom context values from #register! and locale file' do
      Errawr.register!(:error_hash, name: 'register!_name')
      begin
        Errawr.error!(:error_hash, name: 'error!_name')
      rescue => e
        e.context[:name].should == 'error!_name'
      end
    end
  end
end