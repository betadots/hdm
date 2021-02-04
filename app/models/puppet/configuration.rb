class Puppet::Configuration < ApplicationRecord
  belongs_to :configurable, polymorphic: true, optional: true
  has_many :values, dependent: :destroy, foreign_key: :puppet_configuration_id

  has_many :child_configurations, class_name: 'Puppet::Configuration', foreign_key: :parent_id
  accepts_nested_attributes_for :child_configurations, allow_destroy: true

  belongs_to :parent_configuration, class_name: 'Puppet::Configuration', foreign_key: :parent_id, optional: true

  validates :name, presence: true
end
