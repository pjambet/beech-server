require 'spec_helper'

describe Badge do
  it { should have_many :awards }
  it { should have_many(:users).through(:awards) }

  describe 'condition mechanism' do
    let(:user) { create :user }
    context 'with a "Drink X beers of type" badge' do
      let(:badge) do
        create :badge, type: 'quantity', condition: 'color:blond', quantity: '10'
      end
    end

    ########################################
    # Quantity
    ########################################

    context 'with a "Drink X beers from country" badge' do
      let(:badge) do
        create :badge, type: 'quantity',
                       condition: 'country:belgium',
                       quantity: '3'
      end

      context 'with a user who didnt satisfy the condition' do
        before(:each) do
          2.times do
            user.checks.create(beer: create(:beer, country: 'belgium'))
          end
        end
        it 'should not be validated' do
          user.deserve_badge?(badge).should be_false
        end
      end

      context 'with a user who satisfies the condition' do
        before(:each) do
          4.times do
            user.checks.create(beer: create(:beer, country: 'belgium'))
          end
        end
        it 'should be validated' do
          user.deserve_badge?(badge).should be_true
        end
      end

    end

    context 'with a "Drink X beers of a given color" badge' do
      let(:badge) do
        create :badge, type: 'quantity', condition: 'color:blond', quantity: '3'
      end

      context 'with a user who didnt satisfy the condition' do
        before(:each) do
          2.times { user.checks.create(beer: create(:beer, :blond )) }
        end

        it 'should not be validated' do
          user.deserve_badge?(badge).should be_false
        end
      end

      context 'with a user who satisfies the condition' do
        before(:each) do
          4.times do
            user.checks.create(beer: create(:beer, :blond ))
          end
        end
        it 'should be validated' do
          user.deserve_badge?(badge).should be_true
        end
      end

    end

    context 'with a "Drink X times a given beer" badge' do
      let(:badge) do
        create :badge, type: 'quantity',
                       condition: 'beer:guiness',
                       quantity: '3'
      end

      context 'with a user who didnt satisfy the condition' do
        before(:each) do
          2.times do
            user.checks.create(beer: create(:beer, name: 'guiness' ))
          end
        end
        it 'should not be validated' do
          user.deserve_badge?(badge).should be_false
        end
      end

      context 'with a user who satisfies the condition' do
        before(:each) do
          4.times do
            user.checks.create(beer: create(:beer, name: 'guiness' ))
          end
        end
        it 'should be validated' do
          user.deserve_badge?(badge).should be_true
        end
      end

    end

    ########################################
    # One of each
    ########################################

    context 'with a "Drink one of each colors" badge' do
      let(:badge) do
        create :badge, type: 'one_of_each',
                       condition: 'color:blond,dark,amber,white',
                       quantity: '10'
      end

      context 'with a user who didnt satisfy the condition' do
        it 'should not be validated'
      end

      context 'with a user who satisfies the condition' do
        it 'should be validated'
      end
    end


    context 'with a "Drink one of each country" badge' do
      let(:badge) do
        create :badge, type: 'one_of_each',
                       condition: 'type:blond,dark,amber,white',
                       quantity: '10'
      end

      context 'with a user who didnt satisfy the condition' do
        it 'should not be validated'
      end

      context 'with a user who satisfies the condition' do
        it 'should be validated'
      end
    end

    ########################################
    # Different
    ########################################

    context 'with a "Drink X different beers" badge' do
      let(:badge) do
        create :badge, type: 'different',
                       condition: 'beer',
                       quantity: '10'
      end

      context 'with a user who didnt satisfy the condition' do
        it 'should not be validated'
      end

      context 'with a user who satisfies the condition' do
        it 'should be validated'
      end
    end


    context 'with a "Drink beers from X different countries" badge' do
      let(:badge) do
        create :badge, type: 'different',
                       condition: 'country',
                       quantity: '10'
      end

      context 'with a user who didnt satisfy the condition' do
        it 'should not be validated'
      end

      context 'with a user who satisfies the condition' do
        it 'should be validated'
      end
    end
  end
end

