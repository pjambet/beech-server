shared_examples 'an admin controller' do |actions|

  def execucte_action(action, opts)
    if opts.is_a?(Symbol)
      send(opts, action)
    elsif opts.is_a?(Hash)
      begin
        send(opts[:method], action, opts[:params])
      rescue ActiveRecord::RecordNotFound => e
        # If this exception is raised, it's that the user had access to the
        # action
        # As it's not the purpose of this spec, we just silently fail
      end
    end
  end

  context 'as an admin user' do
    actions.each_pair do |action, opts|
      let(:user) { create :user, :admin }
      specify "I should be able to access ##{action} via #{opts}" do
        sign_in user
        execucte_action action, opts
        response.status.should eq(200)
      end
    end
  end

  context 'as a regular user' do
    actions.each_pair do |action, opts|
      let(:user) { create :user }
      specify "I should be denied access to ##{action}" do
        sign_in user
        execucte_action action, opts
        response.should redirect_to (new_user_session_path)
      end
    end
  end

  context 'as an anonymous user' do
    actions.each_pair do |action, opts|
      specify "I should be denied access to ##{action}" do
        execucte_action action, opts
        response.should redirect_to (new_user_session_path)
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
