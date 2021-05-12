# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SystemTest', type: :request do
  include_examples 'GET admin examples', '/admin/system_test'
end
