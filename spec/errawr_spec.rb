require 'spec_helper'

describe Errawr do
  describe 'error!' do
    it 'should raise an Errawr::Error exception' do
      Errawr.register!(:dummy_error)
      expect { Errawr.error!(:dummy_error) }.to raise_error(Errawr::Error)
    end
    
    it 'should return custom metadata values using #register!' do
      Errawr.register!(:some_error, metadata: { name: 'custom_register!_name' })
      begin
        Errawr.error!(:some_error)
      rescue => e
        e.metadata[:name].should == 'custom_register!_name'
      end
    end
    
    it 'should return custom metadata values using #error!' do
      Errawr.register!(:some_error, metadata: { name: 'custom_register!_name' })
      begin
        Errawr.error!(:some_error, metadata: { name: 'custom_error!_name' })
      rescue => e
        e.metadata[:name].should == 'custom_error!_name'
      end
    end
    
    it 'should return custom metadata values from locale file' do
      Errawr.register!(:error_hash)
      begin
        Errawr.error!(:error_hash)
      rescue => e
        e.metadata.include?(:name).should be_true
      end
    end
    
    it '#register! should override custom metadata values from locale file' do
      Errawr.register!(:error_hash, metadata: { name: 'register!_name' })
      begin
        Errawr.error!(:error_hash)
      rescue => e
        e.metadata[:name].should == 'register!_name'
      end
    end
    
    it 'should override custom metadata values from #register! and locale file' do
      Errawr.register!(:error_hash, metadata: { name: 'register!_name' })
      begin
        Errawr.error!(:error_hash, metadata: { name: 'error!_name' })
      rescue => e
        e.metadata[:name].should == 'error!_name'
      end
    end
    
    it 'should interpolate locales' do
      Errawr.register!(:interpolated_error, error_message: 'interpolated message')
      begin
        Errawr.error!(:interpolated_error)
      rescue => e
        e.message.should == 'Some error has occurred: interpolated message'
      end
    end
    
    it 'should return an overridden message for a non-hashed locale' do
      begin
        Errawr.error!(:some_error, message: 'Overridden error message')
      rescue => e
        e.message.should == 'Overridden error message'
      end
    end
    
    it 'should return an overridden message for a hashed locale' do
      begin
        Errawr.error!(:error_hash, message: 'Overridden error message')
      rescue => e
        e.message.should == 'Overridden error message'
      end
    end
  end
end