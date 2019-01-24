class User < ApplicationRecord
  has_many :auth_tokens

  has_many :authors

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  has_secure_password

  bitmask :roles, as: %i(user administrator)

  delegate :as_json, to: :decorate
end
