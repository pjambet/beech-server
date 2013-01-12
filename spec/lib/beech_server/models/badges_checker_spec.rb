require 'spec_helper_no_rails'
require 'models/badges_checker'

describe BeechServer::Models::BadgesChecker do
  let(:dummy_class) { Class.send :include, BeechServer::Models::BadgesChecker }

  it 'should exists' do
    dummy_class.should_not be_nil
  end

  context 'with a new instance' do
    subject { dummy_class.new }

    it 'should respond to #unearned_badges' do
      should respond_to(:unearned_badges)
    end

    it 'should respond to #deserves_badge?' do
      should respond_to(:deserves_badge?)
    end

    it 'should respond to #badge' do
      should respond_to(:badge)
    end

    it 'should respond to #badge=' do
      should respond_to(:badge=)
    end
  end
end

describe BeechServer::Models::BadgesChecker::RegularBadgeChecker do
  context 'with a new instance' do
    let(:badge) { stub(:badge) }
    let(:user) { stub(:user) }
    subject { described_class.new badge, user  }

    it 'should respond to #badge' do
      should respond_to(:badge)
    end

    it 'should_not respond to #badge=' do
      should_not respond_to(:badge=)
    end

    it 'should respond to #user' do
      should respond_to(:user)
    end

    it 'should_not respond to #user=' do
      should_not respond_to(:user=)
    end
  end
end

describe BeechServer::Models::BadgesChecker::QuantityBadgeChecker do
  # TODO
  it 'should exist'
end

describe BeechServer::Models::BadgesChecker::OneOfEachBadgeChecker do
  # TODO
  it 'should exist'
end

describe BeechServer::Models::BadgesChecker::DifferentBadgeChecker do
  # TODO
  it 'should exist'
end
