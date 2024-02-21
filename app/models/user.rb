class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }, if: -> { new_record? || password.present? }

  def self.authenticate_with_credentials(email, password)
    normalized_email = email.downcase.strip
    user = User.find_by(email: normalized_email)

    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
