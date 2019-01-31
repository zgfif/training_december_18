module Api
  class AuthorsController < ApplicationController
    def index
    end

    private
    attr_reader :collection

    def build_collection
      @collection = Author.all.order :name
    end

    def authorize_collection
      authorize collection, policy_class: Api::AuthorPolicy
    end
  end
end
