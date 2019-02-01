require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should belong_to :user }

  it { should validate_presence_of :name }

  it { should validate_uniqueness_of(:name).case_insensitive }

  it { should delegate_method(:as_json).to(:decorate) }

end
