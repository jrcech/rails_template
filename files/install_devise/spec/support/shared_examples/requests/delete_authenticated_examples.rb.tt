# frozen_string_literal: true

RSpec.shared_examples 'DELETE authenticated' do
  describe 'DELETE' do
    let!(:factory) { create resource_singular_symbol }

    context 'with an authenticated user' do
      before do
        sign_in_user
      end

      it 'destroys the record' do
        expect do
          delete url_for(action: :destroy, id: factory.id)
        end.to change(model.all, :count).by(-1)
      end
    end

    context 'with a guest' do
      it 'does not destroy the record' do
        expect do
          delete url_for(action: :destroy, id: factory.id)
        end.not_to change(model.all, :count)
      end
    end
  end
end
