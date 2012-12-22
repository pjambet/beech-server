require 'spec_helper'

describe Check do
  it { should belong_to :user }
  it { should belong_to :beer }

  it { should validate_presence_of :user }
  it { should validate_presence_of :beer }

  it { should have_db_index([:user_id, :beer_id])}

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

        create :badge, condition: 'true'

        expect { check.check_if_user_earned_new_badges }.to change{
          Award.count
        }.by(1)
      end
    end

  end
end

