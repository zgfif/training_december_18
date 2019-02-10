require 'rails_helper'

RSpec.describe Backoffice::AuthorsController, type: :controller do
  it { should be_an Backoffice::ApplicationController }

  describe '#resource' do
    before { subject.instance_variable_set :@resource, :resource }

    its(:resource) { should eq :resource }
  end

  describe '#resource_params' do
    let(:params) { acp author: { name: nil } }

    before { expect(subject).to receive(:params).and_return(params) }

    before { expect(subject).to receive(:current_user).and_return(:current_user) }

    its(:resource_params) { should eq params[:author].merge(user: :current_user).permit! }
  end

  describe '#find_resource' do
    let(:params) { acp id: nil }

    before { expect(subject).to receive(:params).and_return(params) }

    before { expect(Author).to receive(:find).with(params[:id]).and_return(:resource) }

    before { subject.send :find_resource }

    its(:resource) { should eq :resource }
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:resource_params).and_return(:resource_params) }

    before { expect(Author).to receive(:new).with(:resource_params).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource  }
  end

  describe '#create.json' do
    let(:resource) { double }

    before { expect(subject).to receive(:authenticate!).and_return(true) }

    before { expect(subject).to receive(:authorize_resource).and_return(true) }

    before{ expect(subject).to receive(:build_resource) }

    before { expect(subject).to receive(:resource).and_return(resource)}

    context do
      before { expect(resource).to receive(:save).and_return(true) }

      before { post :create, params: {}, format: :json }

      it { should render_template(:create).with_status(201) }
    end

    context do
      before { expect(resource).to receive(:save).and_return(false) }

      before { post :create, params: {}, format: :json }

      it { should render_template(:errors).with_status(422) }
    end
  end

  describe '#collection' do
    context do
      before { subject.instance_variable_set :@collection, :collection }

      its(:collection) { should eq :collection }
    end

    context do
      before { expect(Author).to receive(:order).with(:name).and_return(:collection) }

      its(:collection) { should eq :collection }
    end
  end

  describe '#authorize_collection' do
    before { expect(subject).to receive(:collection).and_return(:collection)  }

    it { expect(subject).to receive(:authorize).with(:collection, policy_class: Backoffice::AuthorPolicy) }

    after { subject.send :authorize_collection }
  end

  describe '#authorize_resource' do
    before { expect(subject).to receive(:resource).and_return(:resource)  }

    it { expect(subject).to receive(:authorize).with(:resource, policy_class: Backoffice::AuthorPolicy) }

    after { subject.send :authorize_resource }
  end

  describe '#update.json' do
    let(:resource) { double }

    before { expect(subject).to receive(:authenticate!).and_return(true) }

    before { expect(subject).to receive(:authorize_resource).and_return(true) }

    before { expect(subject).to receive(:resource_params).and_return(:resource_params) }

    before { expect(subject).to receive(:find_resource).and_return(:resource) }

    before { expect(subject).to receive(:resource).and_return(resource) }

    context do
      before { expect(resource).to receive(:update).with(:resource_params).and_return(true) }

      before { patch :update, params: { id: 1 }, format: :json }

      it { should render_template(:update).with_status(200) }
    end

    context do
      before { expect(resource).to receive(:update).with(:resource_params).and_return(false) }

      before { patch :update, params: { id: 1 }, format: :json }

      it { should render_template(:errors).with_status(422) }
    end

  end
end
