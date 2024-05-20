require 'rails_helper'

RSpec.describe Footers::FooterComponent, type: :component do
  let(:footer) { build(:footer) }

  describe 'factory' do
    it 'is valid' do
      expect(footer).to be_an_instance_of(described_class)
    end
  end

  it 'renders a base footer' do
    render_inline footer

    aggregate_failures do
      expect_to_have_css_attributes base_footer_css
    end
  end

  context 'with left dropdown' do
    let(:footer) { build(:footer, :with_left_dropdown) }

    it 'renders a footer with left dropdown' do
      render_inline footer

      aggregate_failures do
        expect_to_have_css_attributes dropdown_footer_css
      end
    end
  end

  context 'with pagination' do
    let(:footer) { build(:footer, :with_pagination) }

    it 'renders a footer with pagination' do
      render_inline footer

      aggregate_failures do
        expect_to_have_css_attributes pagination_footer_css
      end
    end
  end

  private

  def base_footer_css
    [
      'footer.row > div.col-md'
    ]
  end

  def dropdown_footer_css
    [
      'footer.row > div.col-md > div.dropdown > a + ul',
      'ul.dropdown-menu > li:nth-child(2)'
    ]
  end

  def pagination_footer_css
    [
      'footer.row > div.col-md + div.col-md > div.float-end > nav.pagy-bootstrap.nav-js',
      'div[data-controller="pagy-initializer"]'
    ]
  end
end
