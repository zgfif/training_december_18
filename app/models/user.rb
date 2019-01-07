# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, uniqueness: true
  validates :email, :password, :password_confirmation, presence: true
  validates :password, confirmation: true

  has_many :auth_tokens
end
