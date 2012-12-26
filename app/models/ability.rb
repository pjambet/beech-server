class Ability
  include CanCan::Ability

  def initialize user, params={}
    if user
      can :update, User do |u|
        u.id == user.id
      end
      # TODO : handle admin permissions
    end
  end

end

