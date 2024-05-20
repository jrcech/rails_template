require 'rails_helper'

RSpec.describe Current do
  let(:user) { build_stubbed(:user) }

  describe '#user' do
    it 'sets and returns the user attribute' do
      described_class.user = user

      expect(described_class.user).to eq(user)
    end

    it 'returns nil when user is not set' do
      described_class.reset

      expect(described_class.user).to be_nil
    end
  end
end
