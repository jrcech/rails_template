FactoryBot.define do
  factory :group, class: 'Buttons::GroupComponent' do
    buttons do
      [
        { title: 'Test title 1', path: 'test_path1' },
        { title: 'Test title 2', path: 'test_path2' }
      ]
    end

    title { nil }

    initialize_with { new(**attributes) }

    trait :with_title do
      title { 'Test title' }
    end
  end
end
