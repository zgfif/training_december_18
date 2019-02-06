module Backoffice
  class AvatarPolicy < ApplicationPolicy
    def create?
      !!user&.roles?(:administrator)
    end
  end
end
