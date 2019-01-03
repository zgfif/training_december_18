class ApplicationController < ActionController::Base
  include ActsAsAuthenticatedController
  include ActsAsAuthorizedController

  protect_from_forgery with: :null_session

  before_action -> { response.status = 201 }, only: :create
end
