module Backoffice
  class AuthorsController < ApplicationController
    def create
      render :errors, status: 422 unless resource.save
    end

    private
    attr_reader :resource

    def build_resource
      @resource = Author.new resource_params.merge(user: current_user)
    end

    def resource_params
      params.require(:author).permit(:name)
    end
  end
end
