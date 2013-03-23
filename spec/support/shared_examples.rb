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
