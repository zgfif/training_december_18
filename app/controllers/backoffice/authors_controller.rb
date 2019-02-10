module Backoffice
  class AuthorsController < ApplicationController
    def create
      render :errors, status: 422 unless resource.save
    end

    def update
      render :errors, status: 422 unless resource.update resource_params
    end

    private
    attr_reader :resource

    def build_resource
      @resource = Author.new resource_params
    end

    def find_resource
      @resource ||= Author.find params[:id]
    end

    def resource_params
      params.require(:author).permit(:name, category_ids: []).merge(user: current_user)
    end

    def collection
      @collection ||= Author.order :name
    end

    def authorize_collection
      authorize collection, policy_class: Backoffice::AuthorPolicy
    end

    def authorize_resource
      authorize resource, policy_class: Backoffice::AuthorPolicy
    end
  end
end
