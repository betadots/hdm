class Puppet::Value < ApplicationRecord
  # extend FriendlyId
  # friendly_id :value, use: :slugged
  #
  belongs_to :configuration, foreign_key: :puppet_configuration_id

  validates :value, presence: true

  def to_value
    case puppet_configuration.kind
    when 'string' then "#{value}"
    when 'integer' then value.to_i
    when 'float' then value.to_f
    end
  end
end
