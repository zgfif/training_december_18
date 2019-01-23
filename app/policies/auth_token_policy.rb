class AuthTokenPolicy < ApplicationPolicy
  def destroy?
    user.roles?(:administrator)
  end
end
