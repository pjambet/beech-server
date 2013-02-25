require 'spec_helper'

vcr_options = { cassette_name: 'foursquare/venues', record: :new_episodes }
describe Check, vcr: vcr_options do
  it { should belong_to :user }
  it { should belong_to :beer }

  it { should validate_presence_of :user }
  it { should validate_presence_of :beer }

  it { should have_db_index([:user_id, :beer_id])}
  it { should have_db_column(:lat)}
  it { should have_db_column(:lng)}
  it { should allow_mass_assignment_of(:lat) }
  it { should allow_mass_assignment_of(:lng) }

  context 'with an existing instance' do
    subject { create :check }

    it { should be_persisted }
    it { should validate_presence_of :event }

    it 'should call #check_if_user_earned_new_badges when creating a new check' do
      Check.any_instance.expects(:check_if_user_earned_new_badges).once
      create :check
    end
  end

  describe '#check_if_user_earned_new_badges' do
    let(:check) { create :check }
    context 'when user did not earn new badge' do
      it 'should do nothing' do
        expect { check.check_if_user_earned_new_badges }.to change{
          Award.count
        }.by(0)
      end
    end

    context 'when user earned new badge' do
      it 'should create an award' do

        create :badge, condition: 'any', quantity: 0

        expect { check.check_if_user_earned_new_badges }.to change{
          Award.count
        }.by(1)
      end
    end
  end

  describe '#locate' do
    subject(:check) { create :check }

    it 'should find the H.M.S' do
      check.locate(44.83232, -0.57290).name.should match(/h\.?m\.?s/i)
    end

    it 'should find the fitz patrick' do
      check.locate(43.60834, 3.87645).name.should match(/fitz/i)
    end

    it 'should find titi twister' do
      check.locate(44.83175, -0.56979).name.should match(/titi/i)
    end

    it 'should find les furieux' do
      check.locate(48.85589, 2.37525).name.should match(/furieux/i)
    end
  end
end

