# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  def create
    if resource.save
      render json: @resource.as_json(only: %w[id email]), status: 201
    else
      render json: @resource.errors, status: 422
    end
  end

  private

  def resource
    @resource = User.new resource_params
  end

  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
