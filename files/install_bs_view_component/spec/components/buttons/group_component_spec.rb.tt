require 'rails_helper'

RSpec.describe Buttons::GroupComponent, type: :component do
  let(:group) { build(:group) }

  describe 'factory' do
    it 'is valid' do
      expect(group).to be_an_instance_of(described_class)
    end
  end

  it 'renders a base group of buttons' do
    render_inline group

    aggregate_failures do
      expect_to_have_css_attributes base_button_group_css
    end
  end

  context 'with title' do
    let(:group) { build(:group, :with_title) }

    it 'renders a group with a title' do
      render_inline group

      expect(page).to have_css 'div.btn-group[aria-label="Test title buttons"]'
    end
  end

  private

  def base_button_group_css
    [
      'div.btn-group[role="group"]>a[href="test_path1"]',
      'div>a:nth-child(2)[href="test_path2"]',
      'div.btn-group[aria-label="Buttons group"]'
    ]
  end
end
