require 'spec_helper'

describe Notifier do
  let(:object) { stub }
  let(:user) { stub }
  subject { Notifier.new(object, user) }

  it { should_not be_nil }
end
