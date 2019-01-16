require 'rails_helper'

RSpec.describe UserDecorator do
  let :user do
    stub_model User, id: 13, email: 'pasha@gmail.com'
  end

  subject { user.decorate }

  its :as_json do
    should eq id: 13, email: 'pasha@gmail.com'
  end
end
