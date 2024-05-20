require 'rails_helper'

RSpec.describe Buttons::DropdownComponent, type: :component do
  let(:dropdown) { build(:dropdown) }

  describe 'factory' do
    it 'is valid' do
      expect(dropdown).to be_an_instance_of(described_class)
    end
  end

  it 'renders a default dropdown with buttons' do
    render_inline dropdown

    aggregate_failures do
      expect_to_have_css_attributes base_dropdown_css
    end
  end

  private

  def base_dropdown_css
    [
      'div.dropdown > a.dropdown-toggle + ul.dropdown-menu',
      'a[href="#"]',
      'a[role="button"]',
      'a[aria-expanded="false"]',
      'a[data-bs-toggle="dropdown"]',
      'ul.dropdown-menu > li:nth-child(2) > a.dropdown-item',
      'a.dropdown-item[role="button"]',
      'a.dropdown-item[href="test_path2"]'
    ]
  end
end
