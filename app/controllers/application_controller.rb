class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  include ActsAsAuthorizedController

  before_action -> { response.status = 201 }, only: :create
end
