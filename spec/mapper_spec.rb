require 'spec_helper'

describe Errawr::Mapper do
  it 'should automatically register an unknown error' do
    expect(Errawr::Mapper.all[:unknown]).to_not eq(nil)
  end

  describe '[]' do
    it 'should return stored errors' do
      expect(Errawr::Mapper[:unknown]).to_not eq(nil)
    end
  end

  describe 'add' do
    it 'should add an error to stored errors' do
      Errawr::Mapper.add(DummyError.new)
      expect(Errawr::Mapper[:dummy_key]).to_not eq(nil)
    end
  end

  describe 'register!' do
    it 'should throw an error if base class is not a subclass of Errawr::Error' do
      expect { Errawr.register!(:dummy_error, base_class: StandardError) }.to raise_error(ArgumentError)
    end

    it 'should add an error to stored errors' do
      Errawr.register!(:dummy_error)
      expect(Errawr::Mapper[:dummy_error]).to_not be_nil
    end

    it 'should not add :metadata options to context' do
      begin
        Errawr.error!(:dummy_error, metadata: { name: :same_dummy_error })
      rescue => e
        expect(e.metadata).to_not include(:error)
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

    it 'should override custom metadata values from locale file' do
      begin
        Errawr.error!(:error_hash, metadata: { name: 'register!_name' })
      rescue => e
        expect(e.metadata[:name]).to eq('register!_name')
      end
    end

    it 'should interpolate locales' do
      begin
        Errawr.error!(:interpolated_error, error_message: 'interpolated message')
      rescue => e
        expect(e.message).to eq('Some error has occurred: interpolated message')
      end
    end
  end
end
