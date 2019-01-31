module Api
  class AuthorsController < ApplicationController
    def index
      build_collection
    end

    private
    attr_reader :collection

    def build_collection
      @collection = Author.all.order(:name)
    end
  end
end
