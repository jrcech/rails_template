# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Utilities::FlashMessagesHelper, type: :helper do
  describe 'map bootstrap and icons to flash messages' do
    let(:icon) { 'check' }

    it 'constructs notice hash' do
      expect(
        helper.bootstrap_flash('notice')
      ).to eq class: 'info', icon: 'info-circle'
    end

    it 'constructs success hash' do
      expect(
        helper.bootstrap_flash('success')
      ).to eq class: 'success', icon: 'check'
    end

    it 'constructs error hash' do
      expect(
        helper.bootstrap_flash('error')
      ).to eq class: 'danger', icon: 'exclamation-triangle'
    end

    it 'constructs alert hash' do
      expect(
        helper.bootstrap_flash('alert')
      ).to eq class: 'danger', icon: 'exclamation-triangle'
    end
  end
end
