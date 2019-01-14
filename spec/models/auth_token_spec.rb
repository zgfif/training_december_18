require 'rails_helper'

RSpec.describe AuthToken, type: :model do
  it { should belong_to :user }

  it { should delegate_method(:as_json).to(:decorate) }
end
