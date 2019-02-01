module Backoffice
  class AuthorPolicy < ApplicationPolicy
    def index?
      !!user&.roles?(:administrator)
    end

    def create?
      !!user&.roles?(:administrator)
    end
  end
end
