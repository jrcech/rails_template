# frozen_string_literal: true

RSpec.shared_examples 'POST authenticated' do
  describe 'POST' do
    include_context 'with post attributes'

    context 'with an authenticated user' do
      before do
        sign_in_user
      end

      context 'with valid attributes' do
        include_examples 'creates a new record', :valid_attributes
      end

      context 'with invalid attributes' do
        include_examples 'does not create a new record', :invalid_attributes
      end
    end

    context 'with a guest' do
      context 'with valid attributes' do
        include_examples 'does not create a new record', :valid_attributes
      end

      context 'with invalid attributes' do
        include_examples 'does not create a new record', :invalid_attributes
      end
    end
  end
end
