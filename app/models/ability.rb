
class Ability
  include CanCan::Ability

  def self.role_names
    ['editor', 'publisher', 'manager', 'developer', 'super_user']
  end

  def initialize( user )
    user ||= User.new

    if user.role :super_user || :developer
      can :manage, :all
    elsif user.role :product_admin
      can :manage, [ Product, Order]
    elsif user.role :product_team
      can :read, [ Product, Order]
    end
  end

end

