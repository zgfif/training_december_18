require 'rails_helper'

RSpec.describe AuthTokenDecorator do
  subject { auth_token.decorate }

  let(:user) do
    stub_model User,
      { id: 13,
      email: 'pasha@gmail.com',
      created_at: '2019-01-15',
      updated_at: '2019-01-16' }
  end

  let(:auth_token) do
    stub_model AuthToken,
      id: 11,
      user: user,
      created_at: '2019-01-16',
      updated_at: '2019-01-17'
  end

  its(:as_json) do
    should eq auth_token: 11,  user: { id: 13, email: 'pasha@gmail.com' }
  end
end
