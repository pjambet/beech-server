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

end

