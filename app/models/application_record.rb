class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  before_destroy :ensure_destruction_possible

  private

  def ensure_destruction_possible
    throw :abort if respond_to?(:destroyable?) && !destroyable?
  end
end
