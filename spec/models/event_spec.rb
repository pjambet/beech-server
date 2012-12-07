require 'spec_helper'

describe Event do
  it { should belong_to(:eventable)}
  it { should belong_to(:user)}
  it { should have_db_index(:user_id)}
  it { should have_db_index(:eventable_id)}

  describe '.for_users' do
    # TODO
  end

  describe '.after' do
    # TODO
  end

  describe '.paginate' do
    before(:each) do
      @checks = 50.times.map { create :check }
    end

    it 'should return the 20 first elements for page 1' do
      paginated = Event.paginate
      paginated.size.should == 20
    end

    it 'should return 2 exact differnt lists for 2 different pages' do
      page1 = Event.paginate
      page2 = Event.paginate 2
      page1.size.should == 20
      page2.size.should == 20
      (page1 & page2).should be_empty
    end

  end

  describe '.per_page' do
    it { described_class.per_page.should == 20 }
  end

end
