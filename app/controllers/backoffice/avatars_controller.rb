module Backoffice
  class AvatarsController < ApplicationController
    def create
      resource.avatar.attach resource_params[:avatar]

      unless resource.avatar.image?
        resource.avatar.detach

        resource.errors.add :type, :invalid

        render :errors, status: 422
      end
    end

    private
    attr_reader :resource

    def build_resource
      @resource = Author.find params[:author_id]
    end

    def resource_params
      params.permit(:avatar)
    end

    def authorize_resource
      authorize resource, policy_class: Backoffice::AvatarPolicy
    end
  end
end
