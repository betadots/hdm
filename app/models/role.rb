class Role < ApplicationRecord
  has_many :users

  validates :name, presence: true, inclusion: { in: %w(Admin User), 
            message: "%{value} is not a valid role" }  

  def to_s
    name
  end
end
