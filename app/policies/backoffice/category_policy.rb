module Backoffice
  class CategoryPolicy < ApplicationPolicy
    def create?
      !!user&.roles?(:administrator)
    end
  end
end
