class Group < ApplicationRecord
  RESTRICTABLES = %w(environment node key).freeze

  serialize :rules, Array

  has_many :group_memberships, dependent: :destroy
  has_many :users, through: :group_memberships

  validates :name, presence: true, uniqueness: true
  validates :restrict, inclusion: RESTRICTABLES
  validates :rules, regexp: true, length: {minimum: 1}

  def destroyable?
    group_memberships.none?
  end
end
