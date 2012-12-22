module Rolable
  # TODO : find a better name
  extend ActiveSupport::Concern

  included do
    has_many :memberships
    has_many :roles, through: :memberships
  end

  def admin?
    roles.include? Role.admin_role
  end
end
