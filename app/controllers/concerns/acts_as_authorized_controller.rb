module ActsAsAuthorizedController
  extend ActiveSupport::Concern

  included do
    include Pundit

    rescue_from Pundit::NotAuthorizedError do
      head :forbidden
    end

    before_action :build_resource, only: :create

    before_action :authorize_resource, if: :user_exist?

    helper_method :resource
  end

  private

  def authorize_resource
    authorize resource
  end

  def user_exist?
    resource.user.present?
  end
end
