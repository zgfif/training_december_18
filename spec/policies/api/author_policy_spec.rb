require 'rails_helper'

RSpec.describe Api::AuthorPolicy, type: :policy do
  let(:resource) { nil }

  subject { described_class }

  permissions :index? do
    context do
      let(:user) { stub_model User, id: nil, email: nil }

      it { should permit user, resource }
    end

    context do
      let(:user) { nil }

      it { should_not permit user, resource }
    end
  end
end
