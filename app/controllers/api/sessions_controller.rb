module Api
  class SessionsController < ApplicationController
    include SessionActions

    skip_before_action :authenticate!, only: :create

    skip_before_action :authorize_resource, only: :create
  end
end
