class AuthorPolicy < ApplicationPolicy
  def create?
    user.roles? :administrator
  end
end