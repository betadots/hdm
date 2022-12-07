class Group < ApplicationRecord
  RESTRICTABLES = %w[environment node key].freeze

  serialize :rules, Array

  has_many :group_memberships, dependent: :destroy
  has_many :users, through: :group_memberships

  validates :name, presence: true, uniqueness: true
  validates :restrict, inclusion: RESTRICTABLES
  validates :rules, regexp: true, length: { minimum: 1 }

  def destroyable?
    group_memberships.none?
  end

  def may_access?(record)
    record_class = record.class.name.downcase
    raise "Cannot check #{record_class}" unless record_class == restrict

    compiled_rules.any? { |r| r.match(record.name) }
  end

  private

  def compiled_rules
    @compiled_rules ||= rules.map { |r| Regexp.new(r) }
  end
end
