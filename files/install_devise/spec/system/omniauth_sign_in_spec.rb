# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'OmniAuth', type: :system do
  include_examples 'OmniAuth examples', :facebook
  include_examples 'OmniAuth examples', :google
end
