class User < ApplicationRecord
  has_many :auth_tokens

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  has_secure_password

  delegate :as_json, to: :decorate
end
