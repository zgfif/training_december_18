require 'rails_helper'

RSpec.describe Api::AuthorPolicy, type: :policy do
  subject { described_class }

  let(:resource) { nil }

  permissions :index? do
    context do
      let(:user) { nil }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { stub_model User }

      it { should permit user, resource }
    end
  end
end
