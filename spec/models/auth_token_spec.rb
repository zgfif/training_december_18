require 'rails_helper'

require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.describe AuthToken, type: :model do

  it 'is not valid without any attributes' do
    expect(AuthToken.new).to_not be_valid
  end

  it 'is valid with user_id' do
  DatabaseCleaner.clean

   user = User.create email: 'vv@example.com', password: '22', password_confirmation: '22'

   auth_token = user.auth_tokens.new

   expect(auth_token).to be_valid
  end
end
