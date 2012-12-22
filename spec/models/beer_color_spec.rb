require 'spec_helper'

describe BeerColor do
  it { should have_many :beers }

  describe "#blond" do
    context "when the color doesn't already exists" do
      it 'should create the beer color' do
        expect{BeerColor.blond}.to change{BeerColor.count}.by(1)
      end

      it 'should return the beer color' do
        BeerColor.blond.should_not be_nil
      end
    end

    context 'when the color already exists' do
      before(:each) { create :beer_color, slug: 'blond' }
      it 'should not create the beer color' do
        expect{BeerColor.blond}.to change{BeerColor.count}.by(0)
      end

      it 'should return the beer color' do
        BeerColor.blond.should_not be_nil
      end
    end
  end
end
