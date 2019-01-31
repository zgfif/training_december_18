require 'rails_helper'

RSpec.describe Api::SessionPolicy, type: :policy do
  subject { described_class }

  let(:record) { nil }

  permissions :destroy? do
    context do
      let(:user) { stub_model User, id: nil, email: nil }

      it { should permit user, record }
    end

    context do
      let(:user) { nil }

      it { should_not permit user, record }
    end
  end
end
