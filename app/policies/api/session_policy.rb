module Api
  class SessionPolicy < ApplicationPolicy
    def create?
      !user.present?
    end

    def destroy?
      user.present?
    end
  end
end
