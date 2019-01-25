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
end
