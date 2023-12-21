class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    if user.admin?
      can :manage, :all # Admin can perform any action on any resource
    else
      can :read, :all # Guests and regular users can read any resource

      if user.id
        can :create, Post if user.present?
        can :create, Comment if user.present?
        can :update, Post, user_id: user.id

        can :destroy, Post, author_id: user.id # Allow users to delete their own posts
        can :destroy, Comment, user_id: user.id # Allow users to delete their own comments
      end
    end
  end
end
