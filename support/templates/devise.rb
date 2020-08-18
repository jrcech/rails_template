# frozen_string_literal: true

def install_devise
  generate 'devise:install'

  remove_file 'config/locales/devise.en.yml'
  copy_file 'insert_files/config/locales/devise.en.yml',
            'config/locales/devise.en.yml'

  inject_into_file(
    'config/initializers/devise.rb',
    File.read('./insert_files/config/initializers/devise.rb'),
    after: "config.sign_out_via = :delete\n"
  )

  inject_into_file(
    'config/environments/development.rb',
    File.read('./insert_files/config/environments/development_mailer.rb'),
    after: "config.action_mailer.perform_caching = false\n"
  )

  inject_into_file(
    'config/environments/test.rb',
    File.read('./insert_files/config/environments/test_mailer.rb'),
    after: "config.action_mailer.perform_caching = false\n"
  )

  generate 'devise User'
  uncomment_lines Dir['./db/migrate/*_devise_create_users.rb'].first,
                  /t\.|add/

  generate 'rolify Role User'
  rails_command 'db:migrate'
  uncomment_lines 'config/initializers/rolify.rb',
                  'config.use_dynamic_shortcuts'

  remove_file_comments 'app/models/user.rb'

  gsub_file 'app/models/user.rb',
            'devise :database_authenticatable, :registerable,',
            ''

  gsub_file 'app/models/user.rb',
            ':recoverable, :rememberable, :validatable',
            ''

  gsub_file 'app/models/user.rb',
            'rolify',
            File.read('./insert_files/app/models/user_devise.rb')

  inject_into_file(
    'spec/models/user_spec.rb',
    File.read('./insert_files/spec/models/user_spec.rb'),
    after: "be_valid\nend\n"
  )

  gsub_file 'config/routes.rb',
            'devise_for :users',
            File.read('./insert_files/config/routes_devise.rb')

  copy_file 'files/app/controllers/users/omniauth_callbacks_controller.rb',
            'app/controllers/users/omniauth_callbacks_controller.rb'

  generate 'migration AddNameToUser first_name last_name username'
  generate 'migration AddOmniauthToUser provider uid'

  rails_command 'db:migrate'

  inject_into_file 'spec/factories/users.rb',
                   File.read('./insert_files/spec/factories/users.rb'),
                   after: "factory :user do\n"

  inject_into_file 'spec/factories/roles.rb',
                   "\nname { 'MyString' }",
                   after: "factory :role do\n"
end
