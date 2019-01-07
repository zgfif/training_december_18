# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  def create
    render :errors, status: 422 unless resource.save
  end

  private

  def resource
    @resource = User.new resource_params
  end

  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
