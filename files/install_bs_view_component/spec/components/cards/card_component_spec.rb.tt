require 'rails_helper'

RSpec.describe Cards::CardComponent, type: :component do
  let(:user) do
    build(
      :user,
      email: 'john.doe@example.com',
      first_name: 'John'
    )
  end

  let(:user_presenter) { UserPresenter.new record: user }

  let(:component) do
    described_class.new(
      item: user,
      item_presenter: user_presenter,
      details: %i[email first_name]
    )
  end

  before do
    render_inline(component)
  end

  it 'renders component' do
    expect(page).to have_text 'john.doe@example.com'
  end

  it 'loops through card body' do
    expect(page).to have_css 'p:nth-child(2)', text: 'John'
  end

  it 'stops looping through card body' do
    expect(page).to have_no_css 'p:nth-child(3)'
  end
end
