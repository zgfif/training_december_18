require 'rails_helper'

RSpec.describe Backoffice::AvatarsController, type: :controller do
  it { should be_an Backoffice::ApplicationController }

  describe '#resource' do
    before { subject.instance_variable_set :@resource, :resource }

    its(:resource) { should eq :resource }
  end

  describe '#build_resource' do
    let(:resource_params) { acp id: nil, avatar: nil }

    let(:author) { double }

    before { expect(subject).to receive(:resource_params).and_return(resource_params) }

    before {expect(subject).to receive(:author).and_return(author) }

    before { expect(Backoffice::Avatar).to receive(:new).with(author, resource_params[:avatar]).and_return(:resource) }

    its(:build_resource) { should eq :resource }
  end

  describe '#author' do
    context do
      before { subject.instance_variable_set(:@author, :author) }

      its(:author) { should eq :author }
    end

    context do
      let(:params) { acp author_id: 1 }

      before {expect(subject).to receive(:params).and_return(params) }

      before { expect(Author).to receive(:find).with(params[:author_id]).and_return(:author) }

      its(:author) {should eq :author}
    end
  end

  describe '#resource_params' do
    let(:params) { acp id: nil, avatar: nil }

    before { expect(subject).to receive(:params).and_return(params) }

    its(:resource_params) { should eq params.permit(:avatar) }
  end

  describe '#create.json' do
    let( :resource) { double }

    before { expect(subject).to receive(:authenticate!).and_return(true) }

    before { expect(subject).to receive(:authorize_resource).and_return(true) }

    before { expect(subject).to receive(:resource).and_return(resource) }

    context do
      before { expect(resource).to receive(:valid?).and_return(true) }

      before { expect(subject).to receive(:resource).and_return(resource) }

      before { expect(resource).to receive(:attach_avatar).and_return(true) }

      before { post :create, params: { author_id: 1 }, format: :json }

      it { should render_template(:create).with_status(201) }
    end

    context do
      before { expect(resource).to receive(:valid?).and_return(false) }

      before { post :create, params: { author_id: 1 }, format: :json }

      it { should render_template(:errors).with_status(422) }
    end
  end

  describe '#authorize_resource' do
    before { expect(subject).to receive(:resource).and_return(:resource)  }

    it { expect(subject).to receive(:authorize).with(:resource, policy_class: Backoffice::AvatarPolicy) }

    after { subject.send :authorize_resource }
  end
end
