FactoryBot.define do
  factory :dropdown, class: 'Buttons::DropdownComponent' do
    title { 'Test title' }

    dropdown_items do
      [
        { title: 'Test title 1', path: 'test_path1' },
        { title: 'Test title 2', path: 'test_path2' }
      ]
    end

    id { nil }
    icon { nil }
    data { nil }

    element { nil }
    dropdown_class { nil }
    toggle_class { nil }
    menu_class { nil }

    initialize_with { new(**attributes) }

    trait :full do
      icon { 'test-icon' }
      id { 'TestId' }
      dropdown_class { 'test-class' }
      data { { test_key: 'test-value' } }
    end

    trait :custom_wrapper do
      element { :li }
      dropdown_class { 'custom-wrapper-class' }
    end
  end
end
