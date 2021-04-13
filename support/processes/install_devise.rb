# frozen_string_literal: true

def install_devise
  append_to_file 'Gemfile', File.read('./tmp/inserts/install_devise/Gemfile')
  run 'bundle install'

  run 'DISABLE_SPRING=1 rails generate devise:install'

  remove_file 'config/locales/devise.en.yml'

  # TODO
  # copy_file './tmp/inserts/install_devise/config/locales/devise.en.yml',
  #           'config/locales/devise.en.yml'

  remove_comments_from_file 'config/initializers/devise.rb'

  inject_into_file(
    'config/initializers/devise.rb',
    File.read('./tmp/inserts/install_devise/config/initializers/devise.rb'),
    after: "config.sign_out_via = :delete\n"
  )

  run 'DISABLE_SPRING=1 rails generate devise User'

  remove_comments_from_file 'app/models/user.rb'

  uncomment_lines Dir['./db/migrate/*_devise_create_users.rb'].first,
                  /t\.|add/

  run 'DISABLE_SPRING=1 rails generate rolify Role User'

  rails_command 'db:migrate'
  uncomment_lines 'config/initializers/rolify.rb',
                  'config.use_dynamic_shortcuts'

  gsub_file 'app/models/user.rb',
            'devise :database_authenticatable, :registerable,',
            ''

  gsub_file 'app/models/user.rb',
            ':recoverable, :rememberable, :validatable',
            ''

  gsub_file 'app/models/user.rb',
            'rolify',
            File.read('./tmp/inserts/install_devise/app/models/user_devise.rb')

  inject_into_file(
    'spec/models/user_spec.rb',
    File.read('./tmp/inserts/install_devise/spec/models/user_spec.rb'),
    after: "be_valid\nend\n"
  )

  gsub_file 'config/routes.rb',
            'devise_for :users',
            File.read('./tmp/inserts/install_devise/config/routes.rb')

  copy_file 'files/install_devise/app/controllers/users/omniauth_callbacks_controller.rb',
            'app/controllers/users/omniauth_callbacks_controller.rb'

  run 'DISABLE_SPRING=1 rails generate migration AddNameToUser first_name last_name username'
  run 'DISABLE_SPRING=1 rails generate migration AddOmniauthToUser provider uid'

  rails_command 'db:migrate'

  inject_into_file 'spec/factories/users.rb',
                   File.read('./tmp/inserts/install_devise/spec/factories/users.rb'),
                   after: "factory :user do\n"

  inject_into_file 'spec/factories/roles.rb',
                   "\nname { 'MyString' }",
                   after: "factory :role do\n"

  run 'rubocop config/initializers/devise.rb --auto-correct-all'
  run 'rubocop app/models/user.rb --auto-correct-all'
  run 'rubocop spec/models/user_spec.rb --auto-correct-all'
  run 'rubocop config/routes.rb --auto-correct-all'
  run 'rubocop spec/factories/users.rb --auto-correct-all'
  run 'rubocop spec/factories/roles.rb --auto-correct-all'
end
