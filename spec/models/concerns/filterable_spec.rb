require 'spec_helper'

describe Filterable do
  let(:subject_class) { User }

  it 'should exist' do
    subject_class.should_not be_nil
  end

  it 'should respond to .after' do
    subject_class.should respond_to(:after)
  end

  it 'should respond to .before' do
    subject_class.should respond_to(:before)
  end
end
