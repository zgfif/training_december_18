require 'rails_helper'

RSpec.describe Api::AuthorsController, type: :controller do
  it { should be_an Api::ApplicationController }

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

    it { expect(subject).to receive(:authorize).with(:collection, policy_class: Api::AuthorPolicy) }

    after { subject.send :authorize_collection }
  end

  describe '#index.json' do
    before { expect(subject).to receive(:authenticate!).and_return(true) }

    before { expect(subject).to receive(:authorize_collection).and_return(true) }

    before { get :index, params: {}, format: :json }

    it { should render_template(:index).with_status(200) }
  end
end
