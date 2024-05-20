FactoryBot.define do
  factory :table, class: 'Tables::TableComponent' do
    collection do
      [
        { cells: ['Cell 1', 'Cell 2'] },
        { cells: ['Cell 3', 'Cell 4'] }
      ]
    end

    initialize_with { new(**attributes) }

    trait :with_head do
      thead do
        [
          { cells: ['Head Cell 1', 'Head Cell 2'] },
          { cells: ['Head Cell 3', 'Head Cell 4'] }
        ]
      end
    end

    trait :with_show_path do
      collection do
        [
          { cells: ['Cell 1'], show_path: 'show_path_1' },
          { cells: ['Cell 2'], show_path: 'show_path_2' }
        ]
      end
    end
  end
end
