require 'spec_helper'

describe Notifier do
  let(:object) { stub }
  let(:user) { stub }
  subject { Notifier.new(object, user) }

  it { should_not be_nil }

  describe '#prevent_doubles!' do
    before(:each) { user.like_event }
    context 'with doubles' do
      it { should raise ModelAlreadyNotified }
    end

    context 'without doubles' do
      it { should_not raise ModelAlreadyNotified }
    end
  end
end
