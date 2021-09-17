module HasGroups
  extend ActiveSupport::Concern

  included do
    has_many :group_memberships, dependent: :destroy
    has_many :groups, through: :group_memberships
  end

  def full_name_with_email
    "#{first_name} #{last_name} <#{email}>"
  end

  def may_access?(record)
    return true if groups.none?
    restrictable = record.class.name.downcase
    raise "Unknown entity #{record.class}" unless restrictable.in? Group::RESTRICTABLES
    applicable_groups = groups.where(restrict: restrictable)
    return true if applicable_groups.none?
    applicable_groups.any? { |g| g.may_access?(record) }
  end
end
