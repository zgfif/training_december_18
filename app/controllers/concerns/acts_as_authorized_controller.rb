module ActsAsAuthorizedController
  extend ActiveSupport::Concern

  included do
    include Pundit

    rescue_from Pundit::NotAuthorizedError do
      head :forbidden
    end

    before_action :build_resource, only: :create

    before_action :authorize_resource

    helper_method :resource
  end

  private
  def authorize_resource
    authorize resource
  end
end
