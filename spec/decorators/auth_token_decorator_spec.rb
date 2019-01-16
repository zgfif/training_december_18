require 'rails_helper'

RSpec.describe AuthTokenDecorator do
  let :user do
    stub_model User, id: 13, email: 'pasha@gmail.com'
  end

  let :auth_token do
    stub_model AuthToken, id: 11, user: user
  end

  subject { auth_token.decorate }

  its :as_json do
    should eq auth_token: 11,  user: { id: 13, email: 'pasha@gmail.com' }
  end
end
