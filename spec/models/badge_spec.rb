require 'spec_helper'

describe Badge do
  it { should have_many :awards }
  it { should have_many(:users).through(:awards) }
  it { should validate_presence_of(:condition) }
  it { should have_db_column(:description_fr) }
  it { should have_db_column(:description_en) }

  describe '#description' do
    subject(:badge) do
      build(:badge,
        description_fr: "Une description",
        description_en: "A description")
    end

    context 'without params' do
      its(:description) { should eq('A description') }
    end

    context 'with french locale' do
      subject{ badge.description(:fr) }

      it { should eq('Une description') }
    end

    context 'with english locale' do
      subject { badge.description(:en) }

      it { should eq('A description') }
    end

    context 'with a non existing locale' do
      subject { badge.description(:fifoo) }

      it { should eq('A description') }
    end
  end

  describe 'condition mechanism' do
    let(:user) { create :user }
    subject { user.deserves_badge?(badge) }

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

