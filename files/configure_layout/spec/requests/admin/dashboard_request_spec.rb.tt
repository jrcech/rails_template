# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  before do
    resource_for :root, :admin
  end

  include_examples 'GET /index authenticated'
end
