module Backoffice
  class AuthorsController < Api::ApplicationController
    def create
      render :errors, status: 422 unless resource.save
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
