module Backoffice
  class AvatarsController < ApplicationController
    skip_before_action :authorize_resource

    def create
      resource.avatar.attach resource_params[:avatar]
    end

    private
    attr_reader :resource

    def build_resource
     @resource = Author.find params[:author_id]
    end

    def resource_params
      params.permit(:author_id, :avatar)
    end
  end
end
