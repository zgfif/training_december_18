require 'rails_helper'

RSpec.describe Backoffice::CategoriesController, type: :controller do
  it { should be_an Backoffice::ApplicationController }

  describe '#resource_params' do
    let(:params) { acp category: { name: nil } }

    before { expect(subject).to receive(:params).and_return(params) }

    its(:resource_params) { should eq params[:category].permit! }
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:resource_params).and_return(:resource_params) }

    before { expect(Category).to receive(:new).with(:resource_params).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end

  describe '#resource' do
    before { subject.instance_variable_set :@resource, :resource }

    its(:resource) { should eq :resource }
  end

   describe '#authorize_resource' do
     before { expect(subject).to receive(:resource).and_return(:resource) }

     it { expect(subject).to receive(:authorize).with(:resource, policy_class: Backoffice::CategoryPolicy) }

     after { subject.send :authorize_resource }
   end

   describe '#create.json' do
     before { expect(subject).to receive(:authenticate!).and_return(true) }

     before { expect(subject).to receive(:authorize_resource).and_return(true) }

     before { expect(subject).to receive(:build_resource) }

     context do
       before { expect(subject).to receive_message_chain(:resource, :save).and_return(true) }

       before { post :create, params: {}, format: :json }

       it { should render_template(:create).with_status(201) }
     end

     context do
       before { expect(subject).to receive_message_chain(:resource, :save).and_return(false) }

       before { post :create, params: {}, format: :json }

       it { should render_template(:errors).with_status(422) }
     end
   end
end
