class UserDecorator < Draper::Decorator
  delegate_all

  def as_json *args
    {
      id: id,
      email: email,
      roles: roles
    }
  end
end
