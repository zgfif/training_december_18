class SessionPolicy < ApplicationPolicy
  def create?
    user.roles?(:administrator)
  end
end
