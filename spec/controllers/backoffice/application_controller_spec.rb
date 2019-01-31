require 'rails_helper'

RSpec.describe Backoffice::ApplicationController, type: :controller do
  it { should be_an ActsAsAuthenticatedController }

  it { should be_an ActsAsAuthorizedController }
end
