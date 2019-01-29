require 'rails_helper'

RSpec.describe BasicSession, type: :model do
  subject { described_class.new email: 'pasha@gmail.com', password: '12' }

  it { should delegate_method(:as_json).to(:auth_token).allow_nil }

  it { should validate_presence_of :email }

  it { should validate_presence_of :password }

  it { expect(subject.method(:save).original_name).to eq(:valid?) }

  describe '#auth_token' do
    context do
      before { subject.instance_variable_set :@auth_token, :auth_token }

      its(:auth_token) { should eq :auth_token }
    end

    context do
      before { expect(subject).to receive(:user).and_return(nil) }

      its(:auth_token) { should be_nil }
    end
  end

  context do
    before { expect(subject).to receive_message_chain(:user, :auth_tokens, :create!).and_return(:auth_token) }

    its(:auth_token) { should eq :auth_token }
  end


  describe '#user' do
    context do
      before { subject.instance_variable_set :@user, :user }

      its(:user) { should eq :user }
    end

    context do
      before { expect(User).to receive(:find_by).with(email: 'pasha@gmail.com').and_return(:user) }

      its(:user) { should eq :user }
    end

    context do
      before { described_class.new }

      its(:user) { should be_nil }
    end
  end
end
