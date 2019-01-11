require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.describe User, type: :model do
  before(:each) { DatabaseCleaner.clean }

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

  it "is not valid when the a user with the same email exists" do
    existining_user = User.create email: 'example@gmail.com', password: '123', password_confirmation: '123'

    new_user = User.new email: 'example@gmail.com', password: '3', password_confirmation: '3'

    expect(new_user).to_not be_valid
  end
end
