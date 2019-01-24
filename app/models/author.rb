class Author < Person
  delegate :as_json, to: :decorate

  validates :name, presence: true
end
