require 'rails_helper'

RSpec.describe Backoffice::AvatarsController, type: :controller do
  it { should be_an Backoffice::ApplicationController }

  describe '#resource' do
    before { subject.instance_variable_set :@resource, :resource }

    its(:resource) { should eq :resource }
  end

  describe '#build_resource' do
    let(:params) { acp id: nil, avatar: nil }

    before { expect(subject).to receive(:params).and_return(params) }

    before { expect(Author).to receive(:find).with(params[:id]).and_return(:resource) }

    its(:build_resource) { should eq :resource }
  end

  describe '#resource_params' do
    let(:params) { acp id: nil, avatar: nil }

    before { expect(subject).to receive(:params).and_return(params) }

    its(:resource_params) { should eq params.permit(:avatar) }
  end

  describe '#create.json' do

    let(:resource) { double }

    before { expect(subject).to receive(:authenticate!).and_return(true) }

    before { expect(subject).to receive(:authorize_resource).and_return(true) }

    before{ expect(subject).to receive(:build_resource).and_return(resource) }

    # before { post :create, params: { id: 1 } }

    it { should render_template(:create).with_status(201) }
  end

  describe '#authorize_resource' do
    before { expect(subject).to receive(:resource).and_return(:resource)  }

    it { expect(subject).to receive(:authorize).with(:resource, policy_class: Backoffice::AvatarPolicy) }

    after { subject.send :authorize_resource }
  end
end

__END__
# resource.avatar.attach resource_params[:avatar]
