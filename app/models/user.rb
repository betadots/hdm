class User < ApplicationRecord
  has_secure_password
  belongs_to :role

  before_validation :downcase_email, on: [:create, :update]

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
  validates :first_name, :last_name, presence: true

  def admin?
    self.role && self.role.name == 'Admin'
  end

  def user?
    self.role && self.role.name == 'User'
  end

  private
  def downcase_email
    self.email = self.email.downcase
  end
end
