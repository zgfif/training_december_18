module ActsAsAuthorizedController
  extend ActiveSupport::Concern

  included do
    before_action :build_resource, only: :create

    helper_method :resource
  end
end
