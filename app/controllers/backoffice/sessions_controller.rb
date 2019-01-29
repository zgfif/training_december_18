module Backoffice
  class SessionsController < ApplicationController
    skip_before_action :authenticate!, only: :create

    before_action :authorize_resource, only: :destroy

    def create
      render :errors, status: 422 unless resource.save
    end

    def destroy
      resource.destroy

      head :no_content
    end

    private
    def resource
      @resource ||= AuthToken.find auth_token
    end

    def resource_params
      params.require(:session).permit(:email, :password)
    end

    def build_resource
      @resource = Backoffice::Session.new resource_params
    end
  end
end
