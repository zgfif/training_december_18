require 'rails_helper'

RSpec.describe CategoryDecorator do
  let :category do
    stub_model Category, id: 13, name: 'sci-fi'
  end

  subject { category.decorate }

  its :as_json do
    should eq category: { name: 'sci-fi' }
  end
end
