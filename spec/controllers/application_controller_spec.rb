require "spec_helper"

shared_examples "an application controller" do |exception, code|
  before(:each) do
    Rails.application.config.stubs(:consider_all_requests_local).returns(false)
  end

  controller do
    def index
      if exception == ActionController::RoutingError
        raise exception, nil
      else
        raise exception
      end
    end
  end

  metadata[:example_group][:described_class].class_eval do
    define_method :exception do
      exception
    end
  end


  describe "handling #{exception} exceptions" do
    before(:each) { get :index }
    it { response.should render_template("errors/error_#{code}") }
    it { response.response_code.should eq(code) }
  end
end

describe ApplicationController do
  it_should_behave_like('an application controller',
                        CanCan::AccessDenied,
                        401)
  it_should_behave_like('an application controller',
                        ActionController::RoutingError,
                        404)
  it_should_behave_like('an application controller',
                        ActionController::UnknownController,
                        404)
  it_should_behave_like('an application controller',
                        ::AbstractController::ActionNotFound,
                        404)
  it_should_behave_like('an application controller',
                        ActiveRecord::RecordNotFound,
                        404)
  it_should_behave_like('an application controller',
                        Exception,
                        500)
end
