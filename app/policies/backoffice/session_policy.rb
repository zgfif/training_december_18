module Backoffice
  class SessionPolicy < ApplicationPolicy
    def destroy?
      user.present? && user.roles?(:administrator)
    end
  end
end
