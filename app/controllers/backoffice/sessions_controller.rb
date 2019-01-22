module Backoffice
  class SessionsController < Api::ApplicationController
    skip_before_action :authenticate!, only: :create

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

    def build_resource
      @resource = Session.new resource_params
    end

    def resource_params
      params.require(:session).permit(:email, :password)
    end
  end
end
