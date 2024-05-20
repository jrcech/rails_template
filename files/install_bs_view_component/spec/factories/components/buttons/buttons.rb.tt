FactoryBot.define do
  factory :button, class: 'Buttons::ButtonComponent' do
    title { 'Test title' }
    path { 'test_path' }

    type { nil }
    item { nil }
    action { nil }
    aria_expanded { nil }
    button_class { nil }
    data { nil }
    icon { nil }
    id { nil }
    link_method { nil }

    dropdown_items { nil }

    initialize_with { new(**attributes) }

    trait :full do
      icon { 'test-icon' }
      id { 'TestId' }
      link_method { :test_method }
      action { :test_action }
      aria_expanded { true }
      button_class { 'test-class' }

      data do
        {
          title: 'Test data title',
          confirm: 'Test data confirm',
          commit: 'Test data commit',
          cancel: 'Test data cancel'
        }
      end
    end

    trait :dropdown do
      dropdown_items do
        [
          { title: 'Test title 1', path: 'test_path1' },
          { title: 'Test title 2', path: 'test_path2' }
        ]
      end
    end
  end
end
