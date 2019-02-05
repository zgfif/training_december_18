require 'rails_helper'

RSpec.describe Author, type: :model do
  it { should validate_presence_of :name }

  it { should validate_uniqueness_of(:name).case_insensitive }

  it { should delegate_method(:as_json).to(:decorate) }
end
