FactoryBot.define do
  factory :tooltip, class: 'Tooltips::TooltipComponent' do
    icon { 'tooltip-test-icon' }
    title { 'Tooltip test title' }
    placement { nil }

    text { nil }
    style { nil }
    size { nil }
    fixed_width { nil }
    animation { nil }
    rotation { nil }
    border { nil }
    pull { nil }
    data { nil }

    initialize_with { new(**attributes) }

    trait :full do
      placement { 'tooltip-test-placement' }

      text { 'Tooltip test text' }
      style { 'tooltip-test-style' }
      size { 'tooltip-test-size' }
      fixed_width { true }
      animation { 'tooltip-test-animation' }
      rotation { 'tooltip-test-rotation' }
      border { true }
      pull { 'tooltip-test-pull' }

      data do
        {
          controller: 'tooltip-test-controller',
          tooltip_test_key: 'tooltip-test-value'
        }
      end
    end
  end
end
