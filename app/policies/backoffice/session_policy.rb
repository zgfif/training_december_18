module Backoffice
  class SessionPolicy < ApplicationPolicy
    def create?
      record.user.roles? :administrator
    end
  end
end
