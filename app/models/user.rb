class User < ApplicationRecord
  has_secure_password

  before_validation :downcase_email, on: [:create, :update]

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
  validates :first_name, :last_name, presence: true
  validates :password, length: { minimum: PASSWORD_MIN_LENGTH }

  scope :admins, -> { where(admin: true) }
  scope :regular, -> { where(admin: false) }

  def user?
    !admin?
  end

  def full_name
    [first_name, last_name].join(" ")
  end

  private

  def downcase_email
    self.email = self.email.downcase
  end
end
