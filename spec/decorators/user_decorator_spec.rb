require 'rails_helper'

RSpec.describe UserDecorator do
  subject { user.decorate }

  let(:user) do
    stub_model User,
      id: 13,
      email: 'pasha@gmail.com',
      created_at: '2019-01-15',
      updated_at: '2019-01-16'
  end

  its(:as_json) do
    should eq id: 13, email: 'pasha@gmail.com'
  end
end
