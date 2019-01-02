class User < ApplicationRecord
  bitmask :roles, as: [:user, :admin]

  validates :email, uniqueness: true, presence: true

end
