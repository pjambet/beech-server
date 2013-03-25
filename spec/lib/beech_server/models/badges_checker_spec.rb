require 'spec_helper_no_rails'
require 'models/badges_checker'

describe BeechServer::Models::BadgesChecker do
  subject(:dummy_class) do
    Class.send :include, BeechServer::Models::BadgesChecker
  end

  it { should_not be_nil }

  context 'with a new instance' do
    subject { dummy_class.new }

    it { should respond_to(:unearned_badges) }
    it { should respond_to(:deserves_badge?) }
    it { should respond_to(:badge) }
    it { should respond_to(:badge=) }

  end
end

describe 'badge checkers' do
  let(:badge) { stub('badge') }
  let(:user) { stub('user') }
  describe BeechServer::Models::BadgesChecker::RegularBadgeChecker do
    context 'with a new instance' do
      subject(:instance) { described_class.new badge, user  }

      it { should respond_to(:badge) }
      it { should_not respond_to(:badge=) }
      it { should respond_to(:user) }
      it { should_not respond_to(:user=) }

      describe '#badge_condition_params' do
        let(:badge) { stub 'badge', condition: condition }
        subject { instance.badge_condition_params }

        context 'with a blank condition' do
          let(:condition) { '' }
          it { should be_a(Array) }
          it { should be_empty }
        end

        context 'with a real condition' do
          let(:condition) { 'any:guiness' }
          it { should be_a(Array) }
          it { should_not be_empty }
        end
      end
    end
  end

  describe BeechServer::Models::BadgesChecker::QuantityBadgeChecker do
    subject { described_class.new badge, user }
    it { should respond_to(:check) }
  end

  describe BeechServer::Models::BadgesChecker::OneOfEachBadgeChecker do
    subject { described_class.new badge, user }
    it { should respond_to(:check) }
  end

  describe BeechServer::Models::BadgesChecker::DifferentBadgeChecker do
    subject { described_class.new badge, user }
    it { should respond_to(:check) }
  end
end
