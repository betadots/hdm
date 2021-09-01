class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  before_destroy :ensure_destruction_possible

  private

  def ensure_destruction_possible
    if respond_to?(:destroyable?)
      throw :abort unless destroyable?
    end
  end
end
