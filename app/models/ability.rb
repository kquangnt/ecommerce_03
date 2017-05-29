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
      can :create, Review1
      can :destroy, Review1 do |review1|
        review1.user == user
      end

      can :create, Order
      can :destroy, Order do |order|
        order.user == user
      end
      can :destroy, Cart
      can :read, :all
    end
  end
end
