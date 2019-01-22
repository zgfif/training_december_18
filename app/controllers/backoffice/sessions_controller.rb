module Backoffice
  class SessionsController < Api::ApplicationController
    skip_before_action :authenticate!, only: :create

    def create
      if resource.user.roles?(:administrator)

        render :errors, status: 422 unless resource.save
      else
        render json: {'error': 'Access denied'}, status: :forbidden
      end
    end

    def destroy
      if resource.user.roles?(:administrator)

        resource.destroy

        head :no_content
      else
        render json: {'error': 'Access denied'}, status: :forbidden
      end
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

  def is_admin?
    resource.user.roles?(:administrator)
  end
end
