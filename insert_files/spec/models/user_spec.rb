it 'is valid with valid attributes' do
  user.first_name = 'John'
  user.last_name = 'Doe'
  user.email = 'tester@example.com'
  user.password = SecureRandom.hash
  expect(user).to be_valid
end

it { is_expected.to validate_presence_of :first_name }
it { is_expected.to validate_presence_of :last_name }
it { is_expected.to validate_presence_of :email }
it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

it "returns a user's full name as a string" do
  user = FactoryBot.build(:user, first_name: 'John', last_name: 'Doe')
  expect(user.full_name).to eq 'John Doe'
end
