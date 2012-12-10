module BeechServer::Controllers
  module Concerns
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def load_user(opts = {})
        before_filter :load_user, only: :index

        define_method :load_user do
          @user = if params[:user_id].present?
            User.find(params[:user_id])
          else
            current_user
          end
        end
      end
    end
  end
end
