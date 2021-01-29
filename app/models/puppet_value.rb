class PuppetValue < ApplicationRecord
  extend FriendlyId
  friendly_id :value, use: :slugged

  belongs_to :puppet_configuration

  validates :value, presence: true

  def to_value
    case puppet_configuration.kind
    when 'string' then "#{value}"
    when 'integer' then value.to_i
    when 'float' then value.to_f
    end
  end
end
