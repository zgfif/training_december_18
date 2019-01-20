module ActsAsAuthenticatedController
  extend ActiveSupport::Concern

  included do
    before_action :authenticate!
  end

  def auth_token
    authenticate_with_http_token do |token, options|
      @token = token
    end
  end

  def current_user
    return if auth_token.blank?

    @current_user ||= User.joins(:auth_tokens).where(auth_tokens: { id: auth_token }).first
  end

  def authenticate!
    head :unauthorized unless current_user
  end
end
