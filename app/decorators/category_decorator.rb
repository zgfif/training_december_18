class CategoryDecorator < Draper::Decorator
  delegate_all

  def as_json *args
    { id: id, name: name }
  end
end
