module HasGroups
  extend ActiveSupport::Concern

  included do
    has_many :group_memberships, dependent: :destroy
    has_many :groups, through: :group_memberships
  end

  def full_name_with_email
    "#{first_name} #{last_name} <#{email}>"
  end
end
