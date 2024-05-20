require 'rails_helper'

RSpec.describe Headers::HeaderComponent, type: :component do
  let(:user) do
    build(
      :user,
      email: 'john.doe@example.com',
      first_name: 'John'
    )
  end

  let(:component) do
    described_class.new(
      header: {
        title: user.email,
        icon: 'check'
      },
      main_header: true
    )
  end

  before do
    render_inline component
  end

  it 'renders component' do
    aggregate_failures do
      expect(page).to have_text 'john.doe@example.com'
      expect(page).to have_css 'h1 > i.fa-check'
    end
  end
end
