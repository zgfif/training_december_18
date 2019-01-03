class User < ApplicationRecord
  bitmask :roles, as: [:user, :admin]

  has_many :auth_tokens, dependent: :destroy

  validates :email, uniqueness: true, presence: true

end
