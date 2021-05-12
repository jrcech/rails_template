# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homepage', type: :request do
  include_examples 'GET examples', '/'
end
