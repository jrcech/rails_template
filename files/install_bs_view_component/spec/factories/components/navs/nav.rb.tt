FactoryBot.define do
  factory :nav, class: 'Navs::NavComponent' do
    nav_items do
      [
        { title: 'Test title 1', path: 'test_path1' },
        { title: 'Test title 2', path: 'test_path2' }
      ]
    end

    initialize_with { new(**attributes) }
  end
end
