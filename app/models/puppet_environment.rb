class PuppetEnvironment < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  has_many :puppet_nodes
  
  def to_s
    name
  end
end
