module Backoffice
  class AuthorsController < ApplicationController
    def index
    end

    def create
      render :errors, status: 422 unless resource.save
    end

    private
    attr_reader :resource, :collection

    def build_resource
      @resource = current_user.authors.new resource_params
    end

    def resource_params
      params.require(:author).permit(:name)
    end

    def build_collection
      @collection = Author.all.order :name
    end

    def authorize_collection
      authorize collection, policy_class: Backoffice::AuthorPolicy
    end
  end
end
