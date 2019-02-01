module Backoffice
  class Session < ::Session
    def user
      @user ||= User.with_roles(:administrator).find_by email: email if email
    end
  end
end
