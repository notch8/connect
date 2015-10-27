class Ability
  include CanCan::Ability

  def initialize(user)

    if user.has_role? :admin
      can :manage, :all
    end

    # users can only manage their own needs
    can :manage, Need, {user_id: user.id}
  end
end
