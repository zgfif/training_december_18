class BasicSession
  include ActiveModel::Validations

  attr_accessor :email, :password

  validates :email, :password, presence: true

  validate :incorrect_email, :incorrect_password

  alias_method :save, :valid?

  delegate :as_json, to: :auth_token, allow_nil: true

  def initialize params = {}
    @email = params[:email]

    @password = params[:password]
  end

  def auth_token
    @auth_token ||= user&.auth_tokens&.create!
  end

  def user
    @user ||= User.find_by email: email if email.present?
  end

  def incorrect_email
    return if email.blank?
    errors.add :email, "The #{ email } is incorrect!" if user.blank?
  end

  def incorrect_password
    return if password.blank?

    return if user.blank?

    unless user.authenticate password
      errors.add(:password, 'The password is incorrect!')
    end
  end
end
#
