require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  subject { described_class }

  let(:resource) { nil }

  permissions :create? do
    context do
      let(:user) { nil }

      it { should permit user, resource }
    end

    context do
      let(:user) { stub_model User, id: nil, email: nil }

      it { should_not permit user, resource }
    end
  end
end
