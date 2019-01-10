class User < ApplicationRecord
  has_secure_password

  attr_reader :password_confirmation

  delegate :as_json, to: :decorate

  has_many :auth_tokens

  validates :email, :password, :password_confirmation, presence: true

  validates :email, uniqueness: { case_sensitive: false }

  validates :password, confirmation: true
end
