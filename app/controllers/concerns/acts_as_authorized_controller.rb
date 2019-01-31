module ActsAsAuthorizedController
  extend ActiveSupport::Concern

  included do
    include Pundit

    rescue_from Pundit::NotAuthorizedError do
      head :forbidden
    end

    before_action :build_resource, only: :create

    before_action :authorize_resource, except: :index

    helper_method :resource

    helper_method :collection
  end

  private
  def authorize_resource
    authorize resource
  end
end
