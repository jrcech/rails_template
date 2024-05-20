require 'rails_helper'

RSpec.describe Navbars::NavbarComponent, type: :component do
  let(:navbar) { build(:navbar) }

  describe 'factory' do
    it 'is valid' do
      expect(navbar).to be_an_instance_of(described_class)
    end
  end

  it 'renders a base navbar' do
    render_inline navbar

    aggregate_failures do
      expect_to_have_css_attributes base_navbar_css
    end
  end

  private

  def base_navbar_css
    [
      'nav.navbar.navbar-expand-lg.bg-dark[data-bs-theme="dark"]',
      'nav.navbar > div.container > a.navbar-brand',
      'a.navbar-brand + button.navbar-toggler + div.collapse',
      'button.navbar-toggler > span.navbar-toggler-icon',
      'button.navbar-toggler[type="button"]',
      'button.navbar-toggler[data-toggle="collapse"]',
      'button.navbar-toggler[data-target="#navbarSupportedContent"]',
      'button.navbar-toggler[aria-controls="navbarSupportedContent"]',
      'button.navbar-toggler[aria-expanded="false"]',
      'button.navbar-toggler[aria-label="Toggle navigation"]',
      'div.collapse#navbarSupportedContent',
      'div.collapse > ul.navbar-nav.me-auto > li.nav-item:nth-child(2) > a.nav-link',
      'div.collapse > ul.navbar-nav > li.nav-item:nth-child(2) > a.nav-link'
    ]
  end
end
