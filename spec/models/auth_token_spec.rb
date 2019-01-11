require 'rails_helper'

RSpec.describe AuthToken, type: :model do

  it 'is not valid without any attributes' do
    expect(AuthToken.new).to_not be_valid
  end

  it 'is valid with user_id' do
   user = User.first

   auth_token = user.auth_tokens.new

   expect(auth_token).to be_valid
  end
end
