module HasGroups
  extend ActiveSupport::Concern

  included do
    has_many :group_memberships, dependent: :destroy
    has_many :groups, through: :group_memberships
  end
end
