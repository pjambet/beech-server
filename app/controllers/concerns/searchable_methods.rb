module SearchableMethods
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def can_search_for(resource_name = nil)
      before_filter :search, only: :index

      define_method :search do
        klass = resource_name.to_s.singularize.capitalize.constantize
        inst_var_name = "@#{resource_name}"
        if params[:s].present?
          instance_variable_set(inst_var_name, klass.search_for(params[:s]))
        else
          instance_variable_set(inst_var_name, klass.scoped)
        end
      end
    end
  end
end
