require 'rails_helper'

RSpec.describe Api::ApplicationController, type: :controller do
  it { should be_an ActsAsAuthorizedController }
  it { should be_an ActsAsAuthenticatedController }
end
