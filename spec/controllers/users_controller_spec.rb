require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  context 'a user performs signup' do
    it "should render recently created user's data" do
      headers = {
        "Accept" => "application/json"
      }
      post :create, { user: { email: 'vladlen222@gmail.com', password: '1', password_confirmation: '1' } }, headers
      expect(response).to be_success

    end

    it 'should render errors'
  end
end
