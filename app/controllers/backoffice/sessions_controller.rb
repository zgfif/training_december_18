module Backoffice
  class SessionsController < ApplicationController
    include SessionActions

    skip_before_action :authenticate!, only: :create

    before_action :authorize_resource

   private
    def build_resource
      @resource = Backoffice::Session.new resource_params
    end
  end
end
