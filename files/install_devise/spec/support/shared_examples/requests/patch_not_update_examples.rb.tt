# frozen_string_literal: true

RSpec.shared_examples 'does not update the record' do |attributes|
  it 'does not update the new record' do
    params = {}
    params[resource_singular_symbol] = send attributes

    patch url_for(action: :update, id: factory.id), params: params

    expect(factory.updated_at < factory.reload.updated_at).to eq false
  end
end
