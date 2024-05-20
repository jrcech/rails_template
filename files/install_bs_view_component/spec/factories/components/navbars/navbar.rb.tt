FactoryBot.define do
  factory :navbar, class: 'Navbars::NavbarComponent' do
    brand { 'Test Brand' }

    left_nav do
      [
        { title: 'Test title 1', path: 'test_path1' },
        { title: 'Test title 2', path: 'test_path2' }
      ]
    end

    right_nav do
      [
        { title: 'Test title 3', path: 'test_path3' },
        { title: 'Test title 4', path: 'test_path4' }
      ]
    end

    initialize_with { new(**attributes) }
  end
end
