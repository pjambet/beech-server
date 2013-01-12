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

describe 'badge checkers' do
  let(:badge) { stub('badge') }
  let(:user) { stub('user') }
  describe BeechServer::Models::BadgesChecker::RegularBadgeChecker do
    context 'with a new instance' do
      subject(:instance) { described_class.new badge, user  }

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

      describe '#badge_condition_params' do
        let(:badge) { stub 'badge', condition: condition }
        subject { instance.badge_condition_params }

        context 'with a blank condition' do
          let(:condition) { '' }
          it 'should return a list' do
            should be_a(Array)
          end

          it 'should be empty' do
            should be_empty
          end
        end

        context 'with a real condition' do
          let(:condition) { 'any:guiness' }
          it 'should return a list' do
            should be_a(Array)
          end

          it 'should not be empty' do
            should_not be_empty
          end
        end
      end
    end
  end

  describe BeechServer::Models::BadgesChecker::QuantityBadgeChecker do
    subject { described_class.new badge, user }
    it 'should respond to #check' do
      should respond_to(:check)
    end
  end

  describe BeechServer::Models::BadgesChecker::OneOfEachBadgeChecker do
    subject { described_class.new badge, user }
    it 'should respond to #check' do
      should respond_to(:check)
    end
  end

  describe BeechServer::Models::BadgesChecker::DifferentBadgeChecker do
    subject { described_class.new badge, user }
    it 'should respond to #check' do
      should respond_to(:check)
    end
  end
end
