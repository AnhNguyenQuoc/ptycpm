class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role
      can :manage, :all # if user is admin, can access any action in all controller
    else
      can :manage, :all
    end

  end
end
