class User < ActiveRecord::Base
  has_secure_password

  validates :email, uniqueness: { case_sensitive: false }

  validates :email, presence: true
  validates :name, presence: true

  validates :password, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, password)
    user = User.where("LOWER(email) = ?", email.downcase.strip).first
    if user && user.authenticate(password)
      return user
    end
    nil
  end
end
