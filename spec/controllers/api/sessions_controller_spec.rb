require 'rails_helper'

RSpec.describe Api::SessionsController, type: :controller do
  it { should be_an Api::ApplicationController }

  describe '#resource' do
    before { subject.instance_variable_set :@resource, :resource }

    its(:resource) { should eq :resource }
  end

  describe '#resource_params' do
    let(:params) { acp session: { email: nil, password: nil } }

    before { expect(subject).to receive(:params).and_return(params) }

    its(:resource_params) { should eq params[:session].permit! }
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:resource_params).and_return(:resource_params) }

    before { expect(Api::Session).to receive(:new).with(:resource_params).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end

  describe '#create.json' do
    let(:resource) { double }

    before { expect(subject).to receive(:user_exist?).and_return(true) }

    before { expect(subject).to receive(:build_resource) }

    before { expect(subject).to receive(:authorize_resource).and_return(true) }

    before { expect(subject).to receive(:resource).and_return(resource) }

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

  describe '#destroy' do
    let(:resource) { double }

    before { expect(subject).to receive(:user_exist?).and_return(true) }

    before { expect(subject).to receive(:authorize_resource).and_return(true) }

    before { expect(subject).to receive(:authenticate!).and_return(true) }

    before { expect(subject).to receive(:authorize_resource).and_return(true) }

    before { expect(subject).to receive(:resource).and_return(resource) }

    context do
      before { expect(resource).to receive(:destroy).and_return(true) }

      before { delete :destroy, params: {}, format: :json }

      it { expect(response).to have_http_status(:no_content) }
    end
  end
end

__END__

1) Api::SessionsController#destroy  should receive destroy(*(any args)) 1 time
   Failure/Error: resource.user.present?
     #<Double (anonymous)> received unexpected message :user with (no args)
   # ./app/controllers/concerns/acts_as_authorized_controller.rb:25:in `user_exist?'
   # ./spec/controllers/api/sessions_controller_spec.rb:64:in `block (4 levels) in <top (required)>'
