class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role == true
      can :manage, :all # if user is admin, can access any action in all controller
      can :manage, ActiveAdmin::Page, name: "Dashboard", namespace_name: :admin
    else
      can :manage, User
      can [:create], Order
    end

  end
end
