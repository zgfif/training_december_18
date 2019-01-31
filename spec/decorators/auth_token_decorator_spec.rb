require 'rails_helper'

RSpec.describe AuthTokenDecorator do
  let (:auth_token) { stub_model AuthToken, id: 13 }

  subject { auth_token.decorate }

  describe '#as_json' do
    before { expect(auth_token).to receive(:user).and_return(:user) }

    its(:as_json) { should eq auth_token: 13, user: :user }
  end
end
