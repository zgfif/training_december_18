require 'rails_helper'

RSpec.describe Backoffice::Session, type: :model do
  subject { described_class.new email: 'example@user.com', password: '111' }

  it { should be_an BasicSession }

  describe '#user' do
    context do
      before { subject.instance_variable_set :@user, :user }

      its(:user) { should eq :user }
    end

    context do
      before { expect(User).to receive_message_chain(:with_roles, :find_by).with(email: 'example@user.com').and_return(:user) }

      its(:user) { should eq :user }
    end

    context do
      subject { described_class.new }

      its(:user) { should be_nil }
    end
  end
end
