require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should belong_to :user }

  it { should have_and_belong_to_many :authors }

  it { should validate_presence_of :name }

  it { should validate_uniqueness_of(:name).case_insensitive }

  it { should delegate_method(:as_json).to(:decorate) }

  describe '#update_total_authors' do
    subject { stub_model Category }

    let(:total_count) { double }

    before { expect(subject).to receive_message_chain('author_ids.count').and_return(:total_count) }

    before { expect(subject).to receive_message_chain('authors_count=').with(:total_count) }

    before { expect(subject).to receive(:save).and_return(true) }

    before { subject.update_total_authors }

    it { expect(subject).to eq subject  }
  end
end
