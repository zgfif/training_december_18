class Author < Person
  has_one_attached :avatar

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  delegate :as_json, to: :decorate
end
