require 'spec_helper'

describe Errawr do
  it 'should raise an Errawr::Error exception' do
    Errawr.register!(:dummy_error)
    expect { Errawr.error!(:dummy_error) }.to raise_error(Errawr::Error)
  end
end