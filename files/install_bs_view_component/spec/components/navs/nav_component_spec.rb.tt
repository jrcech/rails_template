require 'rails_helper'

RSpec.describe Navs::NavComponent, type: :component do
  let(:nav) { build(:nav) }

  describe 'factory' do
    it 'is valid' do
      expect(nav).to be_an_instance_of(described_class)
    end
  end

  it 'renders a base navbar' do
    render_inline nav

    aggregate_failures do
      expect_to_have_css_attributes base_nav_css
    end
  end

  private

  def base_nav_css
    [
      'ul.nav > li.nav-item:first-child > a.nav-link[role="button"][href="test_path1"]',
      'ul.nav > li.nav-item:nth-child(2) > a.nav-link[role="button"][href="test_path2"]'
    ]
  end
end
