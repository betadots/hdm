# frozen_string_literal: true

class Ability
  include CanCan::Ability

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
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

    if User.none?
      can :create, User
    else
      return unless user.present?

      if user.admin?
        if User.admins.count > 1
          can :manage, User, id: user.id
        else
          can [:read, :edit, :update], User, id: user.id
        end
        can :manage, User, id: User.where.not(id: user.id).ids
        can :create, User, id: nil
        can :manage, Group
      end

      if user.user?
        can :read, User, id: user.id
        can :update, User, id: user.id
        can :manage, Environment do |environment|
          user.may_access?(environment)
        end
        can :manage, Node do |node|
          user.may_access?(node)
        end
        can :manage, Key do |key|
          user.may_access?(key)
        end
        can :manage, Value
      end
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
end
