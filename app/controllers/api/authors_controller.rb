module Api
  class AuthorsController < ApplicationController
    private
    def collection
      @collection ||= Author.order :name
    end

    def authorize_collection
      authorize collection, policy_class: Api::AuthorPolicy
    end
  end
end
