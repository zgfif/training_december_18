class AuthorDecorator < ApplicationDecorator
  delegate_all

  def as_json *args
    { author: { name: name } }
  end
end
