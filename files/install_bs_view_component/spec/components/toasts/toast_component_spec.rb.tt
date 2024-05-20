require 'rails_helper'

RSpec.describe Toasts::ToastComponent, type: :component do
  let(:toast) { build(:toast) }

  describe 'factory' do
    it 'is valid' do
      expect(toast).to be_an_instance_of(described_class)
    end
  end

  it 'renders a base toast' do
    render_inline toast

    aggregate_failures do
      expect_to_have_css_attributes base_toast_css
    end
  end

  context 'with success' do
    let(:toast) { build(:toast, :success) }

    it 'renders a success toast' do
      render_inline toast

      aggregate_failures do
        expect_to_have_css_attributes success_toast_css
      end
    end
  end

  context 'with danger' do
    let(:toast) { build(:toast, :danger) }

    it 'renders a danger toast' do
      render_inline toast

      aggregate_failures do
        expect_to_have_css_attributes danger_toast_css
      end
    end
  end

  context 'with warning' do
    let(:toast) { build(:toast, :warning) }

    it 'renders a warning toast' do
      render_inline toast

      aggregate_failures do
        expect_to_have_css_attributes warning_toast_css
      end
    end
  end

  private

  def base_toast_css
    [
      'div.toast-container > div.toast#toast-info > div.toast-header + div.toast-body',
      'div.toast-header.text-info.bg-info.bg-opacity-25',
      'div.toast-header > i.fa-info.fa-fw[title="Info"]',
      'div.toast-header > strong.me-auto + small + button.btn-close',
      'div.toast-header > button.btn-close[type="button"][data-bs-dismiss="toast"][aria-label="Close"]',
    ]
  end

  def success_toast_css
    [
      'div.toast#toast-success > div.toast-header + div.toast-body',
      'div.toast-header.text-success.bg-success.bg-opacity-25',
      'div.toast-header > i.fa-check.fa-fw[title="Success"]'
    ]
  end

  def danger_toast_css
    [
      'div.toast#toast-danger > div.toast-header + div.toast-body',
      'div.toast-header.text-danger.bg-danger.bg-opacity-25',
      'div.toast-header > i.fa-exclamation-triangle.fa-fw[title="Danger"]'
    ]
  end

  def warning_toast_css
    [
      'div.toast#toast-warning > div.toast-header + div.toast-body',
      'div.toast-header.text-warning.bg-warning.bg-opacity-25',
      'div.toast-header > i.fa-exclamation.fa-fw[title="Warning"]'
    ]
  end
end
