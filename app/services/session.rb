class Session
  include ActiveModel::Model

  attr_reader :email, :password

  def initialize params = {}
    @email = params[:email]

    @password = params[:password]
  end

  def persisted?
    false
  end

  validates :email, :password, presence: true

  # validate :incorrect_email, :incorrect_password
  validate :user_must_exist, :password_must_pass_authentication

  alias_method :save, :valid?

  delegate :as_json, to: :auth_token, allow_nil: true

  def auth_token
    @auth_token ||= user&.auth_tokens&.create!
  end

  def user
    @user ||= User.find_by_email @email if @email.present?
  end

  # def incorrect_email
  #   mail = User.find_by_email @email
  #
  #   errors.add(:email, "The #{@email} is incorrect!") unless mail
  # end
  #
  # def incorrect_password
  #   person = User.find_by_email @email
  #   if person
  #     unless person.authenticate(@password)
  #       errors.add(:password, 'The password is incorrect!')
  #     end
  #   end
  # end

  def user_must_exist
    return if email.blank?

    errors.add :email, :invalid if user.blank?
  end

  def password_must_pass_authentication
    return if password.blank?

    return if user.blank?

    errors.add :password, :invalid unless user.authenticate password
  end
end
