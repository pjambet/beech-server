require 'spec_helper'

describe BadgeChecker do
  let(:user) { create :user }
  subject(:checker) { BadgeChecker.new(user) }

  describe '#check_if_user_earned_new_badges' do
    context 'when user did not earn new badge' do
      it 'should do nothing' do
        expect { checker.check_if_user_earned_new_badges }.to change{
          Award.count
        }.by(0)
      end
    end

    context 'when user earned new badge' do
      it 'should create an award' do
        create :badge, condition: 'any', quantity: 0
        expect { checker.check_if_user_earned_new_badges }.to change{
          Award.count
        }.by(1)
      end
    end

    describe '#unearned_badges' do

      context 'without badges in the db' do
        its(:unearned_badges) { should be_empty }
      end

      context 'with badges in the db' do
        context 'when user has already earned everything' do
          before(:each) do
            4.times { user.badges << create(:badge) }
          end

          its(:unearned_badges) { should be_empty }
        end

        context 'when user has not earned some badges' do
          before(:each) do
            4.times { create :badge }
            3.times { user.badges << create(:badge) }
          end

          its(:unearned_badges) { should_not be_empty }
          its('unearned_badges.size') { should == 4 }
        end
      end
    end
  end

  context 'checkers' do
    let(:user) { stub('user') }
    let(:badge) { stub('badge') }

    describe BadgeChecker::RegularBadgeChecker do
      context 'with a new instance' do
        subject(:instance) { BadgeChecker::RegularBadgeChecker.new badge, user  }

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

    describe BadgeChecker::QuantityBadgeChecker do
      subject { BadgeChecker::QuantityBadgeChecker.new badge, user }

      it 'should respond to #check' do
        should respond_to(:check)
      end
    end

    describe BadgeChecker::OneOfEachBadgeChecker do
      subject { BadgeChecker::OneOfEachBadgeChecker.new badge, user }

      it 'should respond to #check' do
        should respond_to(:check)
      end
    end

    describe BadgeChecker::DifferentBadgeChecker do
      subject { BadgeChecker::DifferentBadgeChecker.new badge, user }

      it 'should respond to #check' do
        should respond_to(:check)
      end
    end
  end

  describe 'condition mechanism' do
    let(:user) { create :user }
    subject { BadgeChecker.new(user).deserves_badge?(badge) }

    context 'with a "Drink X beers of badge_type" badge' do
      let(:badge) do
        create :badge, badge_type: 'quantity',
                       condition: 'color:blond',
                       quantity: '10'
      end
    end

    ########################################
    # Quantity
    ########################################

    context 'with a "Drink X beers" badge' do
      let(:badge) do
        create :badge, badge_type: 'quantity',
                       condition: 'any',
                       quantity: '3'
      end

      context 'with a user who didnt satisfy the condition' do
        before(:each) do
          2.times do
            user.checks.create(beer: create(:beer))
          end
        end

        it { should be_false }
      end

      context 'with a user who satisfies the condition' do
        before(:each) do
          4.times do
            user.checks.create(beer: create(:beer))
          end
        end

        it { should be_true }
      end

    end

    context 'with a "Drink X beers from country" badge' do
      let(:badge) do
        create :badge, badge_type: 'quantity',
                       condition: 'country:belgium',
                       quantity: '3'
      end

      context 'with a user who didnt satisfy the condition' do
        before(:each) do
          2.times do
            user.checks.create(beer: create(:beer, country: 'belgium'))
          end
        end

        it { should be_false }
      end

      context 'with a user who satisfies the condition' do
        before(:each) do
          4.times do
            user.checks.create(beer: create(:beer, country: 'belgium'))
          end
        end

        it { should be_true }
      end

    end

    context 'with a "Drink X beers of a given color" badge' do
      let(:badge) do
        create :badge, badge_type: 'quantity', condition: 'color:blond', quantity: '3'
      end

      context 'with a user who didnt satisfy the condition' do
        before(:each) do
          2.times { user.checks.create(beer: create(:beer, :blond )) }
        end

        it { should be_false }
      end

      context 'with a user who satisfies the condition' do
        before(:each) do
          4.times do
            user.checks.create(beer: create(:beer, :blond ))
          end
        end

        it { should be_true }
      end

    end

    context 'with a "Drink X times a given beer" badge' do
      # TODO this badge should use beer id
      let(:badge) do
        create :badge, badge_type: 'quantity',
                       condition: 'beer:guiness',
                       quantity: '3'
      end

      context 'with a user who didnt satisfy the condition' do
        before(:each) do
          2.times do
            user.checks.create(beer: create(:beer, name: 'guiness' ))
          end
        end

        it { should be_false }
      end

      context 'with a user who satisfies the condition' do
        before(:each) do
          4.times do
            user.checks.create(beer: create(:beer, name: 'guiness' ))
          end
        end

        it { should be_true }
      end

    end

    ########################################
    # One of each
    ########################################

    context 'with a "Drink one of each colors" badge' do
      let(:badge) do
        create :badge, badge_type: 'one_of_each',
                       condition: 'color:blond,dark,amber,white',
                       quantity: '10'
      end

      context 'with a user who didnt satisfy the condition' do
        before(:each) do
          user.checks.create(beer: create(:beer, :blond))
          user.checks.create(beer: create(:beer, :dark))
        end

        it { should_not be_true }
      end

      context 'with a user who satisfies the condition' do
        before(:each) do
          user.checks.create(beer: create(:beer, :blond))
          user.checks.create(beer: create(:beer, :dark))
          user.checks.create(beer: create(:beer, :amber))
          user.checks.create(beer: create(:beer, :white))
        end

        it { should be_true }
      end
    end


    context 'with a "Drink one of each country" badge' do
      let(:badge) do
        create :badge, badge_type: 'one_of_each',
                       condition: 'countries:belgium,scotland'
      end

      context 'with a user who didnt satisfy the condition' do
        before(:each) do
          user.checks.create(beer: create(:beer, country: 'belgium'))
        end

        it { should_not be_true }
      end

      context 'with a user who satisfies the condition' do
        before(:each) do
          user.checks.create(beer: create(:beer, country: 'belgium'))
          user.checks.create(beer: create(:beer, country: 'scotland'))
        end

        it { should be_true }
      end
    end

    context 'with a "Drink one of each of given list" badge' do
      let(:badge) do
        create :badge, badge_type: 'one_of_each',
                       condition: 'beers:guiness,london stripe'
      end

      context 'with a user who didnt satisfy the condition' do
        before(:each) do
          user.checks.create(beer: create(:beer, name: 'guiness'))
        end

        it { should_not be_true }
      end

      context 'with a user who satisfies the condition' do
        before(:each) do
          user.checks.create(beer: create(:beer, name: 'guiness'))
          user.checks.create(beer: create(:beer, name: 'london stripe'))
        end

        it { should be_true }
      end
    end


    ########################################
    # Different
    ########################################

    context 'with a "Drink X different beers" badge' do
      let(:badge) do
        create :badge, badge_type: 'different',
                       condition: 'beer',
                       quantity: '2'
      end

      context 'with a user who didnt satisfy the condition' do
        before(:each) do
          user.checks.create(beer: create(:beer))
        end

        it { should_not be_true }
      end

      context 'with a user who satisfies the condition' do
        before(:each) do
          2.times { user.checks.create(beer: create(:beer)) }
        end

        it { should be_true }
      end
    end


    context 'with a "Drink beers from X different countries" badge' do
      let(:badge) do
        create :badge, badge_type: 'different',
                       condition: 'country',
                       quantity: '2'
      end

      context 'with a user who didnt satisfy the condition' do
        before(:each) do
          user.checks.create(beer: create(:beer, country: 'belgium'))
        end

        it { should_not be_true }
      end

      context 'with a user who satisfies the condition' do
        before(:each) do
          user.checks.create(beer: create(:beer, country: 'france'))
          user.checks.create(beer: create(:beer, country: 'belgium'))
        end

        it { should be_true }
      end
    end
  end
end

