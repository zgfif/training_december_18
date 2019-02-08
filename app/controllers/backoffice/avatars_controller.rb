module Backoffice
  class AvatarsController < ApplicationController
    def create
      if resource.valid?
        resource.attach_avatar
      else
        render :errors, status: 422
      end
    end

    private
    attr_reader :resource

    def build_resource
      @resource ||= Backoffice::Avatar.new author, resource_params[:avatar]
    end

    def author
      @author ||= Author.find params[:author_id]
    end


    def resource_params
      params.permit(:avatar)
    end

    def authorize_resource
      authorize resource, policy_class: Backoffice::AvatarPolicy
    end
  end
end
