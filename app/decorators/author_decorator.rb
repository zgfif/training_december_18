class AuthorDecorator < Draper::Decorator
  delegate_all

  def as_json *args
    { id: id, name: name, has_avatar: object.avatar.present? }
  end
end
