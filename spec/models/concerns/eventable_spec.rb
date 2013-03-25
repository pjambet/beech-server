require 'spec_helper'

describe Eventable do

  # TODO : use a gem such as acts_as_fu
  let(:subject_class) { Check }

  it 'should have one event' do
    subject_class.new.should respond_to(:event)
  end

end

