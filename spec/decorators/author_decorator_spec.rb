require 'rails_helper'

RSpec.describe AuthorDecorator do
  let :author do
    stub_model Author, id: 13, name: 'Will Smith'
  end

  subject { author.decorate }

  its :as_json do
    should eq id: 13, name: 'Will Smith', has_avatar: false, categories: author.categories
  end
end
