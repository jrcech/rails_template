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

    it 'ensures turbo is loaded', js: true do
      expect(page).to have_text 'Turbo loaded'
    end
  end

  it 'ensures styles are loaded', js: true do
    expect(page).to have_css 'p.css-test', visible: :hidden
  end

  it 'ensures font awesome is loaded', js: true do
    expect(page).to have_css 'svg.fa-check', visible: :visible
  end

  describe 'bootstrap components' do
    it 'ensures styles are loaded', js: true do
      expect(page).to have_css 'p.d-none', visible: :hidden
    end

    it 'ensures javascript is loaded', js: true do
      find_button('Bootstrap?').hover
      expect(page).to have_css 'div.tooltip'
    end
  end
end
