# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'System test', type: :system do
  before do
    sign_in_user
    visit admin_system_test_path
  end

  describe 'javascript components' do
    it 'ensures stimulus is loaded', js: true do
      expect(page).to have_text 'Stimulus loaded'
    end

    it 'ensures jquery is loaded', js: true do
      expect(page).to have_text 'jQuery loaded'
    end

    it 'ensures turbolinks are loaded', js: true do
      expect(page).to have_text 'Turbolinks loaded'
    end
  end

  it 'ensures styles are loaded', js: true do
    expect(page).to have_css 'p.css-test', visible: :hidden
  end
end
