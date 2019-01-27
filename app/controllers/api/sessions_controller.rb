module Api
  class SessionsController < ApplicationController
    include SessionActions

    skip_before_action :authenticate!, only: :create

    private
    def build_resource
      @resource = Api::Session.new resource_params
    end
  end
end
