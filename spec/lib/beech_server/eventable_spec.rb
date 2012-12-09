require 'spec_helper'

describe BeechServer::Eventable do


  let(:dummy_class) do
    Class.new(ActiveRecord::Base) do
      include BeechServer::Eventable
      acts_as_eventable
    end
  end

  it 'should have one event'

end

