module Backoffice
  class SessionsController < Api::ApplicationController
    include SessionActions

    skip_before_action :authenticate!, only: :create

    def pundit_user
      resource.user
    end
  end
end
