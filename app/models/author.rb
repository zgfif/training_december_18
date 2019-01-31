class Author < Person
  delegate :as_json, to: :decorate

  validates :name, presence: true

  validates :name, uniqueness: { case_sensitive: false }
end
