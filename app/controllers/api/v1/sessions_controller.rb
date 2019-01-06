class Api::V1::SessionsController < ApplicationController
  before_action :new_resource, only: :create

  def create
    if resource.valid?
      valid_resource
    else
      invalid_resource
    end
  end

  private

  attr_reader :resource

  def invalid_resource
    @resource = @resource.errors.messages
  end

  def valid_resource
    user_data = { user: @resource.as_json }
    auth_data = { auth_token: @resource.auth_token.id.as_json }
    @resource = auth_data.merge(user_data)
  end

  def new_resource
    @resource = Session.new(resource_params)

  end

  def resource_params
    params.require(:session).permit(:email, :password)
  end
end
