class CategoryDecorator < Draper::Decorator
  delegate_all

  def as_json *args
    { category: { name: name } }
  end
end
