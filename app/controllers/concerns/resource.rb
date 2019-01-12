module Resource
  extend ActiveSupport::Concern

  included do
    skip_before_action :verify_authenticity_token

    before_action :build_resource, only: :create

    before_action -> { response.status = 201 }, only: :create

    helper_method :resource
  end
end
