class Session
  include ActiveModel::Model

  attr_accessor :email, :password

  def initialize params = {}
    @email = params[:email]

    @password = params[:password]
  end

   validates :email, :password, presence: true

   validate :incorrect_email, :incorrect_password

   alias_method :save, :valid?

  def auth_token
    user&.auth_tokens&.create!
  end

  def user
    @user ||= User.find_by email: @email if @email
  end

  def incorrect_email
    emails = User.all.collect {|record| record.email }
    unless emails.include? email
      errors.add(:email, "The #{email} is incorrect!")
    end
  end

  def incorrect_password
    person = User.find_by(email: email)
    if person.present?
      if person.password != password
        errors.add(:password,'Your password is incorrect!')
      end
    end
  end
end
