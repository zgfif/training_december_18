module Backoffice
  class AuthorPolicy < ApplicationPolicy
    def index?
      user.present? && user.roles?(:administrator)
    end

    def create?
      user.present? && user.roles?(:administrator)
    end
  end
end
