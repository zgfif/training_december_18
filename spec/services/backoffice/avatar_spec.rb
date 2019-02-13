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
      let(:params) { ActionDispatch::Http::UploadedFile.new type: 'plain/text', tempfile: 'new.txt' }

      before { expect(subject).to receive(:params).and_return(params) }

      its(:content_type_image?) { should be false }
    end
  end

  describe '#is_image?' do
    let(:call) { -> {subject.is_image? } }

    context do
      subject { described_class.new nil, nil }

      it { expect(&call).to_not change { subject.errors.details } }
    end

    context do
    let(:params) { ActionDispatch::Http::UploadedFile.new type: 'image/png', tempfile: 'lenna.png' }

    subject { described_class.new nil, params }

      context do
        let(:content_type_image?) { true }

        before {expect(subject).to receive(:content_type_image?).and_return(content_type_image?) }

        it { expect(&call).to_not change { subject.errors.details } }
      end

      context do
        let(:content_type_image?) { false }

        before {expect(subject).to receive(:content_type_image?).and_return(content_type_image?) }

        it { expect(&call).to change { subject.errors.details } }
      end
    end
  end
end
