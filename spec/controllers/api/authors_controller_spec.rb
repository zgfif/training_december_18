require 'rails_helper'

RSpec.describe Api::AuthorsController, type: :controller do
  it { should be_an Api::ApplicationController }

  describe '#collection' do
    before { subject.instance_variable_set :@collection, :collection }

    its(:collection) { should eq :collection }
  end

  describe '#build_collection' do
    before do
      expect(Author).to receive(:all) do
        double.tap do |a|
          expect(a).to receive(:order).with(:name).and_return(:collection)
        end
      end
    end
    before { subject.send :build_collection }

    its(:collection) { should eq :collection }
  end

  describe '#index.json' do
    before { expect(subject).to receive(:authenticate!).and_return(true) }

    before { expect(subject).to receive(:build_collection) }

    before { expect(subject).to receive(:authorize_collection).and_return(true) }

    before { get :index, params: {}, format: :json }

    it { should render_template(:index).with_status(200) }
  end

  describe '#authorize_collection' do
    before { expect(subject).to receive(:collection).and_return(:collection)  }

    before do
      expect(subject).to receive(:authorize).with(:collection,
        policy_class: Api::AuthorPolicy).and_return(:authorize_collection)
    end

    its(:authorize_collection) { should eq :authorize_collection }
  end
end
