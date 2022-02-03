# frozen_string_literal: true

RSpec.shared_examples 'does not create a new record' do |attributes|
  it 'does not create a new record' do
    params = {}
    params[resource_singular_symbol] = send(attributes)

    expect do
      post url_for(action: :create), params: params
    end.not_to change(model.all, :count)
  end
end
