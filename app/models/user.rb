class User < ApplicationRecord
   validates :email, uniqueness: true
   validates :email, :password, :password_confirmation, presence: true
   validates :password, confirmation: true
end
