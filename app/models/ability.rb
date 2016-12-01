class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.is_admin?
      can :manage, :all
    else
      can :destroy, User do |current_user|
        current_user == user
      end
      can :read, :all
    end
  end
end
