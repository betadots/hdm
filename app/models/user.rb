class User < ApplicationRecord
  include HasGroups

  ROLES = %w[admin regular api].freeze

  has_secure_password validations: false

  normalizes :username, with: ->(username) { username.strip.downcase }

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, :last_name, presence: true
  validates :password, length: { minimum: PASSWORD_MIN_LENGTH },
                       confirmation: true,
                       allow_nil: true
  validates :role, inclusion: ROLES

  scope :admins, -> { where(role: "admin") }
  scope :regular, -> { where(role: "regular") }
  scope :api, -> { where(role: "api") }

  def admin?
    role == "admin"
  end

  def user?
    role == "regular"
  end

  def api?
    role == "api"
  end

  def full_name
    [first_name, last_name].join(" ")
  end

  def authenticate(given_password)
    password_digest.present? && super
  end
end
