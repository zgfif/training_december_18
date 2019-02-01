module Backoffice
  class CategoriesController < ApplicationController
    def create
      render :errors, status: 422 unless resource.save
    end

    private
    attr_reader :resource

    def build_resource
      @resource = Category.new resource_params
    end

    def resource_params
      params.require(:category).permit(:name).merge(user: current_user)
    end

    def authorize_resource
      authorize resource, policy_class: Backoffice::CategoryPolicy
    end
  end
end
#
