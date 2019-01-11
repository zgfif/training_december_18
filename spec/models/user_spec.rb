require 'rails_helper'

RSpec.describe User, type: :model do
  it "is not valid without any attributes" do
    expect(User.new).to_not be_valid
  end

  it "is valid with all attributes" do
    user = User.new email: 'example@gmail.com', password: '123', password_confirmation: '123'

    expect(user).to be_valid
  end

  it "is not valid without a email" do
    user = User.new email: '', password: '123', password_confirmation: '123'

    expect(user).to_not be_valid
  end

  it "is not valid without a password" do
    user = User.new email: 'example@gmail.com', password: '', password_confirmation: '123'

    expect(user).to_not be_valid
  end

  it "is not valid without a password_confirmation" do
    user = User.new email: 'example@gmail.com', password: '123', password_confirmation: ''

    expect(user).to_not be_valid
  end

  it "is not valid when password and password_confirmation different" do
    user = User.new email: 'example@gmail.com', password: '123', password_confirmation: '12'

    expect(user).to_not be_valid
  end
end
