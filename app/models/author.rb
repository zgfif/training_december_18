class Author < Person
  has_and_belongs_to_many :categories

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  delegate :as_json, to: :decorate
end
