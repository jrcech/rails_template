FactoryBot.define do
  factory :toast, class: 'Toasts::ToastComponent' do
    flash do
      { info: 'Toast test flash' }
    end

    initialize_with { new(**attributes) }

    trait :success do
      flash do
        { success: 'Toast test success flash' }
      end
    end

    trait :danger do
      flash do
        { danger: 'Toast test danger flash' }
      end
    end

    trait :warning do
      flash do
        { warning: 'Toast test warning flash' }
      end
    end
  end
end
