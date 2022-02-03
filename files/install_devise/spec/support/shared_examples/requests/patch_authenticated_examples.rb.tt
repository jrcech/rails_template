# frozen_string_literal: true

RSpec.shared_examples 'PATCH authenticated' do
  describe 'PATCH' do
    let(:factory) { create resource_singular_symbol }

    include_context 'with patch attributes'

    context 'with an authenticated user' do
      before do
        sign_in_user
      end

      context 'with valid attributes' do
        include_examples 'updates the record', :valid_attributes
      end

      context 'with invalid attributes' do
        include_examples 'does not update the record', :invalid_attributes
      end
    end

    context 'with a guest' do
      context 'with valid attributes' do
        include_examples 'does not update the record', :valid_attributes
      end

      context 'with invalid attributes' do
        include_examples 'does not update the record', :invalid_attributes
      end
    end
  end
end
