# frozen_string_literal: true

RSpec.shared_examples 'creates a new record' do |attributes|
  it 'creates a new record' do
    params = {}
    params[resource_singular_symbol] = send attributes

    expect do
      post url_for(action: :create), params: params
    end.to change(model.all, :count).by(1)
  end
end
