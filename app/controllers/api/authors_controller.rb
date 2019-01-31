module Api
  class AuthorsController < ApplicationController
  before_action :build_collection
    def index
      collection
      # p 'aaaaa'
      # collection.first
      # render json: collection, status: :ok
      # render json: collection if collection
    end

    private
    attr_reader :collection

    def build_collection
      @collection = Author.all
    end
  end
end
