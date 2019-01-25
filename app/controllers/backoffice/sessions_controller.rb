module Backoffice
  class SessionsController < ApplicationController
    skip_before_action :authenticate!, :authorize_resource, only: :create

    def create
      render :errors, status: 422 unless resource.save
    end

    private
    attr_reader :resource

    def resource_params
      params.require(:session).permit(:email, :password)
    end

    def build_resource
      @resource = Backoffice::Session.new resource_params
    end
  end
end
