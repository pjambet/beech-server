require 'spec_helper'

describe Api::ApplicationController do
  context "Current locale" do
    controller(Api::ApplicationController) do
      def index
        render nothing: true
      end
    end

    context 'without headers' do
      before(:each) do
        get :index
      end
      it { I18n.locale.should eq(:en) }
    end

    context 'with correct value' do
      before(:each) do
        request.env['HTTP_ACCEPT_LANGUAGE'] = 'fr'
        get :index
      end
      it { I18n.locale.should eq(:fr) }
    end

    context 'with wrong value ' do
      before(:each) do
        request.env['HTTP_ACCEPT_LANGUAGE'] = 'foo'
        get :index
      end
      it { I18n.locale.should eq(:en) }
    end

    context 'with nil value ' do
      before(:each) do
        request.env['HTTP_ACCEPT_LANGUAGE'] = nil
        get :index
      end
      it { I18n.locale.should eq(:en) }
    end

  end

end
