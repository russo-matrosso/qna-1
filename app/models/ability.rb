class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
    can :all, User

  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :read, :all
    can [:create, :make_comment], [Question, Answer, Comment]
    can [:update, :destroy], [Question, Answer], user_id: user.id
    can [:like, :dislike, :cancel], [Question, Answer] do |votable|
      votable.user_id != user.id
    end
    can :destroy, Link, linkable: { user_id: user.id }
    can :mark_as_best, Answer, question: {user_id: user.id}
    can :me, User, user_id: user.id
  end
end
