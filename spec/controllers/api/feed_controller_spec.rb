require 'spec_helper'

describe Api::FeedController do
  let(:user) { create :user }

  it_should_behave_like 'an api controller', {
    index: :get,
  }

  describe "GET 'index'" do
    let(:params) { {} }
    let(:beer) { create :beer, beer_color: BeerColor.blond }

    def create_check_for_user(user, date=DateTime.now)
      check = create(:check, user: user, beer: beer)
      check.event.created_at = date
      check.event.save
      check.reload
    end

    context 'when logged in' do
      before(:each) do
        Event.stubs(:per_page).returns(4)
        sign_in user
        checks = []
        checks << create_check_for_user(user, 4.days.ago)
        checks << create_check_for_user(user, 6.days.ago)
        @my_events = checks.map(&:event)

        # Set up a user I follow with some events
        other_user = create(:user)
        user.follow(other_user)
        other_checks = []
        other_checks << create_check_for_user(other_user, 2.days.ago)
        other_checks << create_check_for_user(other_user, 1.days.ago)
        @all_events = (@my_events + other_checks.map(&:event)).sort_by! do |ev|
          ev.created_at
        end
        @marker = @all_events[1] # we'll use for before/after params
        get :index, params.merge(format: :json)
      end

      context 'without params' do
        it { expect(assigns(:events)).to match_array(@all_events) }
        it { expect(assigns(:events).size).to be <= Event.per_page }
      end

      context 'with users = me' do
        let(:params) { {users: 'me'} }

        it { expect(assigns(:events).size).to be <= Event.per_page }
        it { expect(assigns(:events)).to match_array(@my_events) }
      end

      context 'with after' do
        let(:params) { {after: @marker.created_at.to_i} }

        it { expect(assigns(:events).size).to be <= Event.per_page }
        it "should only return events created after the given date" do
          past_events = @all_events[2..-1]
          expect(assigns(:events)).to match_array(past_events)
        end
      end

      context 'with before' do
        let(:params) { {before: @marker.created_at.to_i} }

        it { expect(assigns(:events).size).to be <= Event.per_page }
        it 'should only return events created before the given time' do
          new_events = @all_events[0..0]
          expect(assigns(:events)).to match_array(new_events)
        end
      end

      context 'pagination' do
        before(:each) do
          2.times { create_check_for_user(user, 2.days.ago) }
          get :index, params.merge(format: :json)
        end

        it { expect(assigns(:events).size).to be <= Event.per_page }
      end
    end
  end
end

