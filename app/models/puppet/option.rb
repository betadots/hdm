class Puppet::Option < ApplicationRecord
  include Puppet::Configurable

  belongs_to :node, foreign_key: :puppet_node_id
end
