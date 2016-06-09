class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    if user.is_admin?
      can :manage, :all
    end

    if user.is_editor?
      can :manage, Section
      can :manage, Content
      can :read, :all
    end

    if user.is_player?
      can :read, :all
      can :create, Game
      can [:update, :destroy], Game do |game|
        game.player_one == user.auth_obj || game.player_two == user.auth_obj
      end
      can [:update, :destroy], Player, user_id: user.id
    end

    can :read, Section
    can :read, Content
    can :read, User, id: user.id
    can :create, Player
  end
end
