require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.describe Api::UsersController, type: :controller do

  before(:each) { DatabaseCleaner.clean }

  context 'a user performs signup' do

    it "should render recently created user's data" do
      params = { user: {email: 'exe21@gmail.com', password: '1', password_confirmation: '1'}}
      post :create, params: params, as: :json
      expect(response).to have_http_status(:created)
    end

    it 'should render errors' do
      params = { user: {email: 'danny@gmail.com', password: '1', password_confirmation: '2'}}
      post :create, params: params, as: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
