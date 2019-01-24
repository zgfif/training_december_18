module Api
  class ApplicationController < ActionController::Base
    include ActsAsAuthenticatedController

    include ActsAsAuthorizedController

    skip_before_action :verify_authenticity_token

    before_action -> { response.status = 201 }, only: :create
  end
end
