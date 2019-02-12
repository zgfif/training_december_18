require 'rails_helper'

RSpec.describe Backoffice::Avatar, type: :model do
  subject { described_class.new author, nil }

  let(:author) {stub_model Author, id: 1 }

  it { should be_an(ActiveModel::Validations) }

  it { should delegate_method(:as_json).to(:author).allow_nil }

  describe '#attach_avatar' do
    let(:params) {acp author_id: 1, avatar: '../Pictures/lenna.png' }

    before {expect(subject).to receive(:author).and_return(author) }

    before { expect(subject).to receive(:params).and_return(params) }

    before {expect(subject).to receive(:author).and_return(author) }

    before { expect(author).to receive_message_chain(:avatar, :attach).with(params).and_return(:attach_avatar) }

    its(:attach_avatar) { should be :attach_avatar }
  end

  describe '#content_type_image?' do
    before { stub_const("CONTENT_TYPE", ['image/png', 'image/jpeg']) }

    context do
      let(:params) { ActionDispatch::Http::UploadedFile.new type: 'image/png', tempfile: 'lenna.png' }

      before { expect(subject).to receive(:params).and_return(params) }

      its(:content_type_image?) { should be true }
    end

    context do
      let(:params) { ActionDispatch::Http::UploadedFile.new type: 'plain/text', tempfile: 'lenna.png' }

      before { expect(subject).to receive(:params).and_return(params) }

      its(:content_type_image?) { should be false }
    end
  end
end
