class Category < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  delegate :as_json, to: :decorate
end
