require 'spec_helper'

describe JournalEntry do
  it { should belong_to(:loggable) }
  it { should validate_presence_of(:entry_type) }
  it { should validate_presence_of(:loggable) }

  describe 'Loggable (with beers)' do

    describe 'create' do
      let(:beer) { Beer.create(name: 'Kro') }
      before(:each) { beer.accepted=true; beer.save }

      it { JournalEntry.last.loggable.should eq(beer) }
      it { JournalEntry.last.entry_type.should eq('new') }
    end

    describe 'update' do
      let(:beer) { Beer.create(name: 'Kro') }
      before(:each) do
        beer.accepted=true
        beer.save
        beer.name = 'foo'
        beer.save
      end

      it { JournalEntry.last.loggable.should eq(beer) }
      it { JournalEntry.count.should eq(2) }
      it { JournalEntry.last.entry_type.should eq('edit') }
    end

    describe 'destroy' do
      let(:beer) { Beer.create(name: 'Kro') }
      before(:each) do
        beer.accepted=true
        beer.save
        beer.destroy
      end

      it { JournalEntry.last.loggable_type.should eq('Beer') }
      it { JournalEntry.last.loggable_id.should eq(beer.id) }
      it { JournalEntry.count.should eq(2) }
      it { JournalEntry.last.entry_type.should eq('deletion') }
    end
  end
end
