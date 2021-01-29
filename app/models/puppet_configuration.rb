class PuppetConfiguration < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :puppet_node
  has_many :puppet_values, dependent: :destroy

  validates :name, presence: true

  def build_configuration_with_values
    values = puppet_values.sort_by(&:id).map(&:to_value)
    if multiple_values?
      values
    else
      values.first
    end
  end
end
