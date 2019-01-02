class UsersController < ApplicationController
  wrap_parameters :user, include: %i(email password password_confirmation)

  def create
    # p "The resource is #{resource}"
    render :errors, status: 422 unless resource.save
  end

  private
  attr_reader :resource

  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def build_resource
    p "The resource_params is #{resource_params}"
    @resource = UserFactory.build resource_params
  end
end
