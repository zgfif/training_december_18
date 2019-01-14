class AuthToken < ApplicationRecord
  belongs_to :user

  delegate :as_json, to: :decorate
end
