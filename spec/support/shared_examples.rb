shared_examples 'an admin controller' do |actions|

  def execute_action(action, opts)
    if opts.is_a?(Symbol)
      begin
        send(opts, action)
      rescue ActionController::ParameterMissing
      end
    elsif opts.is_a?(Hash)
      begin
        send(opts[:method], action, opts[:params])
      rescue ActiveRecord::RecordNotFound, ActionController::ParameterMissing
        # If this exception is raised, it's that the user had access to the
        # action
        # As it's not the purpose of this spec, we just silently fail
      end
    end
  end

  context 'when logged in as an admin user' do
    actions.each_pair do |action, opts|
      let(:user) { create :user, :admin }
      specify "I should be able to access ##{action} via #{opts}" do
        sign_in user
        execute_action action, opts
        response.status.should eq(200)
      end
    end
  end

  context 'when logged in  as a regular user' do
    actions.each_pair do |action, opts|
      let(:user) { create :user }
      specify "I should be denied access to ##{action}" do
        sign_in user
        execute_action action, opts
        response.should redirect_to (new_user_session_path)
      end
    end
  end

  context 'when logged in  as an anonymous user' do
    actions.each_pair do |action, opts|
      specify "I should be denied access to ##{action}" do
        execute_action action, opts
        response.should redirect_to (new_user_session_path)
      end
    end
  end
end

shared_examples 'an api controller' do |actions|

  def execute_action(action, opts)
    if opts.is_a?(Symbol)
      begin
        send(opts, action, format: :json)
      rescue ActionController::ParameterMissing
        ActionController::TestResponse.any_instance.stubs(:body).returns('{}')
      end
    elsif opts.is_a?(Hash)
      begin
        send(opts[:method], action, opts[:params].merge(format: :json))
      rescue ActiveRecord::RecordNotFound, ActionController::ParameterMissing => e
        # If this exception is raised, it's that the user had access to the
        # action
        # As it's not the purpose of this spec, we just silently fail
        ActionController::TestResponse.any_instance.stubs(:body).returns('{}')
      end
    end
  end

  context 'when logged in as an admin user' do
    actions.each_pair do |action, opts|
      let(:user) { create :user, :admin }
      before(:each) do
        Rails.application.config.stubs(:consider_all_requests_local)
        .returns(false)
        sign_in user
        execute_action action, opts
      end
      specify "I should be able to access ##{action} via #{opts}" do
        response.status.should eq(200)
      end

      it "should return a valid JSON object for ##{action}" do
        JSON.parse(response.body).should be_a(Hash)
      end
    end
  end

  context 'when logged in as a regular user' do
    actions.each_pair do |action, opts|
      let(:user) { create :user }
      before(:each) do
        Rails.application.config.stubs(:consider_all_requests_local)
        .returns(false)
        sign_in user
        execute_action action, opts
      end

      specify "I should be authorize access to ##{action}" do
        response.status.should eq(200)
      end

      it "should return a valid JSON object for ##{action}" do
        JSON.parse(response.body).should be_a(Hash)
      end
    end
  end

  context 'when logged in as an anonymous user' do
    actions.each_pair do |action, opts|
      specify "I should be denied access to ##{action}" do
        execute_action action, opts
        response.status.should eq(401)
      end
    end
  end
end

shared_examples 'image serializer' do |opts={}|

  let(:field_name) do
    opts[:field_name] || 'photo'
  end

  let(:url_field_name) do
    "#{field_name}_url"
  end

  let(:factory_name) do
    opts[:factory_name] || described_class.to_s.underscore.split(/_/).first
  end

  describe 'image url' do
    let(:instance) do
      create factory_name
    end
    subject(:serializer) { described_class.new instance }

    it 'should have a hash' do
      serializer.send(url_field_name).should be_a(Hash)
    end

    it 'should have a url key' do
      serializer.send(url_field_name).should have_key(:url)
    end

    it 'should have the image url' do
      serializer.send(url_field_name)[:url].should include(instance.send(field_name).url)
    end

    it 'should have a thumb url' do
      serializer.send(url_field_name)[:thumb][:url].should include(instance.send(field_name).thumb.url)
    end
  end
end
