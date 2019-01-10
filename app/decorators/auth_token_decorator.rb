class AuthTokenDecorator < ApplicationDecorator
  delegate_all

  def as_json *args
    {
      auth_token: id,
      user: user
    }
  end
end
