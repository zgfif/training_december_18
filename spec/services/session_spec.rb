require 'rails_helper'

RSpec.describe Session, type: :model do
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

  describe '#incorrect_email' do
    let(:call) { -> { subject.incorrect_email } }

    subject { described_class.new }

    context do

      it { expect(&call).to_not change { subject.errors.details } }
    end

    context do
      # subject { described_class.new }

      it { expect(&call).to_not change { subject.errors.details } }
    end

    context do
      subject { described_class.new email: 'user@example.com' }

      let(:user) { stub_model User, id: 1 }

      before { expect(subject).to receive(:user).and_return(user) }

      it { expect(&call).to_not change { subject.errors.details } }
    end

    context do
      subject { described_class.new email: 'user@example.com' }

      let(:user) { nil }

      before { expect(subject).to receive(:user).and_return(user) }

      it { expect(&call).to change { subject.errors.details } }
    end
  end

  describe '#incorrect_password' do
    let(:call) { -> { subject.incorrect_password } }

    context do
      subject { described_class.new }

      it { expect(&call).to_not change { subject.errors.details } }
    end

    context do
      subject { described_class.new password: '123' }

      it { expect(&call).to_not change { subject.errors.details } }
    end

    context do
      subject { described_class.new email: 'user@example.com' }

      it { expect(&call).to_not change { subject.errors.details } }
    end

    context do
      subject { described_class.new email: 'user@example.com', password: '123' }

      it { expect(&call).to_not change { subject.errors.details } }
    end


    context do
      let(:user) { stub_model User, email: 'user@example.com', password: '123' }

      context do
        subject { described_class.new email: 'user@example.com', password: '123' }

        before { expect(subject).to receive(:user).and_return(user) }

        before { expect(subject).to receive(:user).and_return(user) }

        it { expect(&call).to_not change { subject.errors.details } }
      end

      context do
        subject { described_class.new email: 'user@example.com', password: '12' }

        before { expect(subject).to receive(:user).and_return(user) }

        before { expect(subject).to receive(:user).and_return(user) }

        it { expect(&call).to change { subject.errors.details } }
      end
    end
  end
end
