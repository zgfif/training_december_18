class Category < ApplicationRecord
  has_and_belongs_to_many :authors, association_foreign_key: 'person_id', join_table: 'categories_people'

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  delegate :as_json, to: :decorate
end
