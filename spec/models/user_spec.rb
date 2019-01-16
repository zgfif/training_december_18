require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many :auth_tokens }

  it { should validate_presence_of :email }

  it { should validate_uniqueness_of(:email).case_insensitive }

  it { should have_secure_password }

  it { should delegate_method(:as_json).to(:decorate) }
end
