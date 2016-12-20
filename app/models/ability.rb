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
      can :destroy, Review do |review|
        review.user == user
      end
      can :create, Order
      can :destroy, Order do |order|
        order.user == user
      end
      can :destroy, Cart
      can :create, Review
      can :read, :all
    end
  end
end
