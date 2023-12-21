class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    if user.admin?
      can :manage, :all # Admin can perform any action on any resource
    else
      can :read, :all # Guests and regular users can read any resource

      if user.id
        can :create, Post
        can :update, Post, user_id: user.id
        can :destroy, Post, user_id: user.id # Allow users to delete their own posts
      end
    end
  end
end
