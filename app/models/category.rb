class Category < ApplicationRecord
  belongs_to :user

  has_and_belongs_to_many :authors

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  delegate :as_json, to: :decorate

  def update_total_authors
    total_count = self.author_ids.count
    
    self.authors_count = total_count

    self.save
  end
end
