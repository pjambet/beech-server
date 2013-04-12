require 'spec_helper'

describe Event do

  it { should belong_to(:eventable)}
  it { should belong_to(:user)}
  it { should have_db_index(:user_id)}
  it { should have_db_index(:eventable_id)}
  it { should act_as_likable }

  describe 'default_scope' do
    it 'should order results by descending created_at' do
      10.times { create :event, created_at: rand(10).days.ago }
      events = Event.scoped
      events[0..-2].each_with_index do |event, i|
        event.created_at.should > events[i + 1].created_at
      end
    end
  end

  describe '.for_users' do
    context 'with nil param' do
      it 'should return an empty list' do
        events = Event.for_users(nil)
        events.should be_empty
      end
    end

    context 'with a non Enumerable param' do
      it 'should return an empty list' do
        events = Event.for_users(1)
        events.should be_empty
      end
    end

    context 'with an Enumerable param' do
      let(:users) { 2.times.map { create :user } }
      let(:other_users) { 2.times.map { create :user } }
      before(:each) do
        (users + other_users).each do |u|
          create :event, user: u
        end
        @events = Event.for_users(users)
      end

      it 'should return events for given users' do
        user_ids = users.map(&:id)
        @events.each do |event|
          user_ids.should include(event.user_id)
        end
      end

      it 'should not return events for other users' do
        other_users_ids = other_users.map(&:id)
        @events.each do |event|
          other_users_ids.should_not include(event.user_id)
        end
      end
    end
  end

  describe '.after' do
    before(:each) do
      # Prevent checks created by event factory to trigger creation
      # of an event upon their creation.
      Check.any_instance.stubs(:create_event).returns(nil)
    end

    context 'when params is 0' do
      before(:each) do
        @events = 2.times.map { |i| create :event, created_at: i.day.ago }
      end
      it 'should not apply any filter' do
        Event.after(0).size.should == 2
        Event.after('0').size.should == 2
      end
    end
    context "when there's no event after the last fetched" do
      before(:each) do
        @events = 5.times.map { |i| create :event, created_at: i.day.ago }
      end

      it 'should return an empty list' do
        last_event = @events.sort_by{|e| e.created_at}.last
        Event.after(last_event.created_at.to_i).should == []
      end
    end

    context "when there are new events" do
      before(:each) do
        @events = 5.times.map { |i| create :event, created_at: i.day.ago }
      end

      it 'should return all events after the given timestamp' do
        event = @events.sort_by{|e| e.created_at}.second
        Event.after(event.created_at.to_i).size.should == 3
      end

    end
  end

  describe '.page' do

    before(:each) { Event.stubs(:per_page).returns(2) }
    it 'should return the first elements for page 1' do
      @checks = 3.times.map { create :check }
      paginated = Event.page 1
      paginated.size.should == 2
    end

    it 'should return 2 exact different lists for 2 different pages' do
      @checks = 5.times.map { create :check }
      page1 = Event.page 1
      page2 = Event.page 2
      page1.size.should == 2
      page2.size.should == 2
      (page1 & page2).should be_empty
    end

  end

  describe 'filterable behavior' do
    it 'should respond to .after' do
      Event.should respond_to(:after)
    end

    it 'should respond to .before' do
      Event.should respond_to(:before)
    end
  end

  describe '.per_page' do
    it { described_class.per_page.should == 30 }
  end

end
