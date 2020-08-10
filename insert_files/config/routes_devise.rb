devise_for :users,
           only: :omniauth_callbacks,
           controllers: {
               omniauth_callbacks: 'users/omniauth_callbacks'
           }

scope '(:locale)', locale: /en|cs/ do
  devise_for :users, skip: :omniauth_callbacks

  namespace :admin do
    get :frontend_test, to: 'frontend_test#index'
    root to: 'dashboard#index'
  end

  get '/:locale', to: 'admin/dashboard#index'
  root to: 'admin/frontend_test#index'
end
