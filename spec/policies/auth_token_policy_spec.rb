require 'rails_helper'

RSpec.describe AuthTokenPolicy, type: :policy do
  let(:resource) { nil }

  subject { described_class }

  permissions :destroy? do
    context do
      let(:user) { stub_model User, roles: :administrator }

      it { should permit user, resource }
    end

    context do
      let(:user) { stub_model User, roles: :user }

      it { should_not permit user, resource }
    end
  end
end
