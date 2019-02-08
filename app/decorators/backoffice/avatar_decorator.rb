class AvatarDecorator < Draper::Decorator
  delegate_all

  def as_json *args
    p "AAAAAAA"
    # { id: 'avatar' }
  end
end
