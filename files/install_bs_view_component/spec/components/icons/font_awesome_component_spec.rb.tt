require 'rails_helper'

RSpec.describe Icons::FontAwesomeComponent, type: :component do
  let(:font_awesome) { build(:font_awesome) }

  describe 'factory' do
    it 'is valid' do
      expect(font_awesome).to be_an_instance_of(described_class)
    end
  end

  it 'renders a base font awesome' do
    render_inline font_awesome

    aggregate_failures do
      expect_to_have_css_attributes base_fontawesome_css
    end
  end

  context 'with all attributes' do
    let(:font_awesome) { build(:font_awesome, :full) }

    it 'renders a full font awesome' do
      render_inline font_awesome

      aggregate_failures do
        expect(page).to have_text 'Test text'

        expect_to_have_css_attributes full_fontawesome_css
      end
    end
  end

  private

  def base_fontawesome_css
    [
      'i.fa-solid.fa-test-icon[title="Test title"][data-controller="font-awesome"]'
    ]
  end

  def full_fontawesome_css
    [
      'i.fa-test-icon',
      'i.test-style',
      'i.fa-test-size',
      'i.fa-fw',
      'i.fa-test-animation',
      'i.fa-test-rotation',
      'i.fa-border',
      'i.fa-pull-test-pull',
      'i[title="Test title"]',
      'i[data-test-key="test-value"]',
      'i[data-controller="font-awesome test-controller"]'
    ]
  end
end
