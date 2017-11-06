class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role == "admin"
      can :manage, :all # if user is admin, can access any action in all controller
    elsif user.role == "customer"
      can :manage, :all
    end

  end
end
