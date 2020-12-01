class PuppetNode < ApplicationRecord
  belongs_to :puppet_environment

  def to_s
    fqdn
  end
end
