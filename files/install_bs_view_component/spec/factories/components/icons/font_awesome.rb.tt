FactoryBot.define do
  factory :font_awesome, class: 'Icons::FontAwesomeComponent' do
    icon { 'test-icon' }
    title { 'Test title' }
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
      text { 'Test text' }
      style { 'test-style' }
      size { 'test-size' }
      fixed_width { true }
      animation { 'test-animation' }
      rotation { 'test-rotation' }
      border { true }
      pull { 'test-pull' }
      data {
        {
          controller: 'test-controller',
          test_key: 'test-value'
        }
      }
    end
  end
end
