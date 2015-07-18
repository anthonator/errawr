require 'spec_helper'

describe Errawr do
  describe 'error!' do
    it 'should raise an Errawr::Error exception' do
      expect { Errawr.error!(:dummy_error) }.to raise_error(Errawr::Error)
    end

    it 'should return custom metadata values using #register!' do
      Errawr.register!(:some_error, metadata: { name: 'custom_register!_name' })
      begin
        Errawr.error!(:some_error)
      rescue => e
        expect(e.metadata[:name]).to eq('custom_register!_name')
      end
    end

    it 'should return custom metadata set with #register! using #error!' do
      Errawr.register!(:some_error, metadata: { name: 'custom_register!_name' })
      begin
        Errawr.error!(:some_error, metadata: { name: 'custom_error!_name' })
      rescue => e
        expect(e.metadata[:name]).to eq('custom_error!_name')
      end
    end

    it 'should return custom metadata values from locale file' do
      begin
        Errawr.error!(:error_hash)
      rescue => e
        expect(e.metadata).to include(:name)
      end
    end

    it 'should override custom metadata values from #register! and locale file using #error!' do
      Errawr.register!(:error_hash, metadata: { name: 'register!_name' })
      begin
        Errawr.error!(:error_hash, metadata: { name: 'error!_name' })
      rescue => e
        expect(e.metadata[:name]).to eq('error!_name')
      end
    end

    it 'should return an overridden message for a non-hashed locale' do
      begin
        Errawr.error!(:some_error, message: 'Overridden error message')
      rescue => e
        expect(e.message).to eq('Overridden error message')
      end
    end

    it 'should return an overridden message for a hashed locale' do
      begin
        Errawr.error!(:error_hash, message: 'Overridden error message')
      rescue => e
        expect(e.message).to eq('Overridden error message')
      end
    end

    it 'should pass in interpolated params' do
      begin
        Errawr.error!(:interpolated_error, error_message: 'interpolated message')
      rescue => e
        expect(e.message).to eq('Some error has occurred: interpolated message')
      end
    end
  end
end
