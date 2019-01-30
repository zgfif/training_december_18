require 'rails_helper'

RSpec.describe Backoffice::AuthorsController, type: :controller do
  it { should be_an Api::ApplicationController }

  describe '#resource' do
    before { subject.instance_variable_set :@resource, :resource }

    its(:resource) { should eq :resource }
  end

  describe '#resource_params' do
    let(:params) { acp author: { name: 'Sam Smith' } }

    before { expect(subject).to receive(:params).and_return(params) }

    its(:resource_params) { should eq params[:author].permit! }
  end

  describe '#build_params' do
    let(:current_user) { stub_model User, id: 1 }

    let (:resource_params) { double }

    before { expect(subject).to receive(:current_user).and_return(current_user) }

    before { expect(subject).to receive(:resource_params).and_return(:resource_params) }

    before { expect(current_user).to receive_message_chain('authors.new').and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource  }
  end

  describe '#create.json' do
    let(:resource) { double }

    let(:current_user) { double }

    before { expect(subject).to receive(:authenticate!).and_return(current_user) }

    before { expect(subject).to receive(:authorize_resource).and_return(true) }

    before{ expect(subject).to receive(:build_resource) }

    before { expect(subject).to receive(:resource).and_return(resource)}

    context do
      before { expect(resource).to receive(:save).and_return(true) }

      before { post :create, params: {}, format: :json }

      it do
        should render_template(:create).with_status(201)
      end
    end

    context do
      before { expect(resource).to receive(:save).and_return(false) }

      before { post :create, params: {}, format: :json }

      it do
        should render_template(:errors).with_status(422)
      end
    end
  end
end
