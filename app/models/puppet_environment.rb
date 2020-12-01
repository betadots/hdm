class PuppetEnvironment < ApplicationRecord
  has_many :puppet_nodes
  
  def to_s
    name
  end
end
