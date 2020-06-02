class User < ActiveRecord::Base
  has_secure_password

  validates :email, uniqueness: { case_sensitive: false }

  validates :email, presence: true
  validates :name, presence: true

  validates :password, length: { minimum: 6 }
end
