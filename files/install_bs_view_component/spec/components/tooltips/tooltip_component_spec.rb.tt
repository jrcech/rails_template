require 'rails_helper'

RSpec.describe Tooltips::TooltipComponent, type: :component do
  let(:tooltip) { build(:tooltip) }

  describe 'factory' do
    it 'is valid' do
      expect(tooltip).to be_an_instance_of(described_class)
    end
  end

  it 'renders a base tooltip' do
    render_inline tooltip

    aggregate_failures do
      expect_to_have_css_attributes base_tooltip_css
    end
  end

  context 'with all attributes' do
    let(:tooltip) { build(:tooltip, :full) }

    it 'renders a full tooltip' do
      render_inline tooltip

      aggregate_failures do
        expect(page).to have_text 'Tooltip test text'

        expect_to_have_css_attributes full_tooltip_css
      end
    end
  end

  private

  def base_tooltip_css
    [
      'i.fa-solid.fa-tooltip-test-icon',
      'i[title="Tooltip test title"]',
      'i[data-bs-target="tooltip"]',
      'i[data-controller="font-awesome"]'
    ]
  end

  def full_tooltip_css
    [
      'i + span.ms-1',
      'i.fa-tooltip-test-icon',
      'i.tooltip-test-style',
      'i.fa-tooltip-test-size',
      'i.fa-fw',
      'i.fa-tooltip-test-animation',
      'i.fa-tooltip-test-rotation',
      'i.fa-border',
      'i.fa-pull-tooltip-test-pull',
      'i[title="Tooltip test title"]',
      'i[data-bs-target="tooltip"]',
      'i[data-tooltip-test-key="tooltip-test-value"]',
      'i[data-controller="font-awesome tooltip-test-controller"]'
    ]
  end
end
