module Api
  class UsersController < ApplicationController
    def create
      render :errors, status: 422 unless resource.save
    end

    private
    attr_reader :resource

    def build_resource
      @resource = User.new resource_params
    end

    def resource_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  end
end