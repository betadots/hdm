class Puppet::Environment < ApplicationRecord
  include Puppet::Configurable

  has_many :nodes, class_name: 'Puppet::Node', foreign_key: :puppet_environment_id, dependent: :destroy
end
