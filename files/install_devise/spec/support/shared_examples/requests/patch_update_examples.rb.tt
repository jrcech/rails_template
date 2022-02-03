# frozen_string_literal: true

RSpec.shared_examples 'updates the record' do |attributes|
  it 'updates the new record' do
    params = {}
    params[resource_singular_symbol] = send attributes

    patch url_for(action: :update, id: factory.id), params: params

    expect(factory.updated_at < factory.reload.updated_at).to eq true
  end
end
