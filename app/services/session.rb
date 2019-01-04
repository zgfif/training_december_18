class Session
  include ActiveModel::Model

  attr_accessor :email, :password

  delegate :as_json, to: :auth_token, allow_nil: true

  def initialize params = {}
    @email = params[:email]

    @password = params[:password]
  end

  def persisted?
    false
  end

  def auth_token
    @auth_token ||= user&.auth_tokens&.create!
  end

  alias_method :save, :valid?

  private

  def user
    @user ||= User.find_by email: email if email.present?
  end
end
