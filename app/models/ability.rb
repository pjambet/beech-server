class Ability
  include CanCan::Ability

  def initialize user, params={}
    if user && user.admin?
      can :manage, :all
    elsif user
      can :update, User do |u|
        u.id == user.id
      end
      can :read, :all
    end
  end

end

