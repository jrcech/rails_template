# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Utilities::FontAwesomeHelper, type: :helper do
  describe 'create font awesome html icon' do
    let(:icon) { 'check' }

    it 'constructs with text' do
      expect(
        helper.fa_icon(icon, text: 'Test')
      ).to eq("<i class='fas fa-check'></i> <span>Test</span>")
    end

    it 'constructs with size' do
      expect(
        helper.fa_icon(icon, size: 'sm')
      ).to eq("<i class='fas fa-check fa-sm'></i>")
    end

    it 'constructs with style' do
      expect(
        helper.fa_icon(icon, style: 'fab')
      ).to eq("<i class='fab fa-check'></i>")
    end

    it 'constructs with fixed width' do
      expect(
        helper.fa_icon(icon, fixed_width: true)
      ).to eq("<i class='fas fa-check fa-fw'></i>")
    end

    it 'constructs with animation' do
      expect(
        helper.fa_icon(icon, animation: 'spin')
      ).to eq("<i class='fas fa-check fa-spin'></i>")
    end

    it 'constructs with rotation' do
      expect(
        helper.fa_icon(icon, rotation: 'rotate-90')
      ).to eq("<i class='fas fa-check fa-rotate-90'></i>")
    end

    it 'constructs with border' do
      expect(
        helper.fa_icon(icon, border: true)
      ).to eq("<i class='fas fa-check fa-border'></i>")
    end

    it 'constructs with pull' do
      expect(
        helper.fa_icon(icon, pull: 'right')
      ).to eq("<i class='fas fa-check fa-pull-right'></i>")
    end
  end
end
