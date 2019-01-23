require 'rails_helper'

RSpec.describe AuthTokenPolicy, type: :policy do
  let(:resource) { nil }

  subject { described_class }

  permissions :destroy? do
    context do
      let(:user) { User.new roles: :administrator }

      it { should permit user, resource }
    end

    context do
      let(:user) { User.new roles: :user }

      it { should_not permit user, resource }
    end
  end
end
