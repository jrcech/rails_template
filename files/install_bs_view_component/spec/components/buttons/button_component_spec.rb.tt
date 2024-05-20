require 'rails_helper'

RSpec.describe Buttons::ButtonComponent, type: :component do
  let(:button) { build(:button) }

  describe 'factory' do
    it 'is valid' do
      expect(button).to be_an_instance_of(described_class)
    end
  end

  it 'renders a base button' do
    render_inline button

    aggregate_failures do
      expect_to_have_css_attributes base_button_css
    end
  end

  context 'with all attributes' do
    let(:button) { build(:button, :full) }

    it 'renders a full button' do
      render_inline button

      aggregate_failures do
        expect(page).to have_text 'Test title'

        expect_to_have_css_attributes full_button_css
      end
    end
  end

  context 'with dropdown items' do
    let(:button) { build(:button, :dropdown) }

    it 'renders a dropdown button' do
      render_inline button

      aggregate_failures do
        expect(page).to have_text 'Test title'

        expect_to_have_css_attributes dropdown_button_css
      end
    end
  end

  private

  def base_button_css
    [
      'a[role="button"][href="test_path"]'
    ]
  end

  def full_button_css
    [
      'i.fa-test-icon',
      'a[aria-expanded="true"]',
      'a[class="test-class"]',
      'a[href="test_path"]',
      'a[id="TestId"]',
      'a[data-method="test_method"]',
      'a[data-title="Test data title"]',
      'a[data-confirm="Test data confirm"]',
      'a[data-commit="Test data commit"]',
      'a[data-cancel="Test data cancel"]',
      'a[role="button"]'
    ]
  end

  def dropdown_button_css
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
