module Backoffice
  class AuthorsController < Api::ApplicationController
    # skip_before_action :authorize_resource, :authenticate!

    def create
      render :errors unless resource.save
    end

    private
    attr_reader :resource

    def build_resource
      @resource = current_user.authors.new resource_params
    end

    def resource_params
      params.require(:author).permit(:name)
    end
  end
end
